/* 
 * This module is used to deploy a VPC that span across 2 AZ
 *
 * The only resource deployed in this VPC is Postgres DB
 *
 * The db will be access via vpc peering from others vpc
 *
 * This module will deploy a vpc structured in this way
 * 
 * - Private subnets for db
 * - route table with vpc peering routes
 * - ACL and SG definition 
 *
*/

/* Create main VPC */
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-${var.environment}-environment"
  }
}

/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw-${var.environment}-environment"
  }
}

/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc        = true
  count      = length(var.public_subnets_cidr)
  depends_on = [aws_internet_gateway.ig]

  tags = {
    Name = "nat-eip-${element(var.availability_zones, count.index)}-${var.environment}-environment"
  }
}

/* NAT */
resource "aws_nat_gateway" "nat" {
  depends_on    = [aws_internet_gateway.ig, aws_subnet.public_subnet]
  count         = length(var.public_subnets_cidr)
  subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)

  tags = {
    Name = "nat-${element(var.availability_zones, count.index)}-${var.environment}-environment"
  }
}

/* Routing table for db private subnets */
resource "aws_route_table" "private_route_db" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.db_private_subnets_cidr)

  tags = {
    Name = "route-table-${var.environment}-POSTGRES-${element(var.availability_zones, count.index)}"
  }
}

/* Routing table for private subnets */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.private_subnets_cidr)

  tags = {
    Name = "private-route-table-${element(var.availability_zones, count.index)}-${var.environment}-environment"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "public-route-table-${var.environment}-environment"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

resource "aws_route" "private_nat_gateway" {
  count                  = length(aws_subnet.private_subnet)
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
}

/* Route table associations */
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

/* Route table associations for instances in private subnets*/
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

/* Route table associations for RDS in private subnet*/
resource "aws_route_table_association" "db_private" {
  count          = length(var.db_private_subnets_cidr)
  subnet_id      = element(aws_subnet.db_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_db.*.id, count.index)
}

/*==== Subnets ======*/
/* Public subnet */
resource "aws_subnet" "public_subnet" {

  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${element(var.availability_zones, count.index)}-${var.environment}-environment"
    // Tag needed for bind EKS to ALB created from terraform
    "kubernetes.io/role/elb"                           = "1"
    "kubernetes.io/cluster/eks-${var.environment}-env" = "owned"
    "ingress.k8s.aws/resource"                         = "LoadBalancer"
    "elbv2.k8s.aws/cluster"                            = "eks-${var.environment}-env"
  }
}

/* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name                                               = "private-subnet-${element(var.availability_zones, count.index)}-${var.environment}-environment"
    "kubernetes.io/cluster/eks-${var.environment}-env" = "owned"
  }
}

/* DB Subnets */
resource "aws_subnet" "db_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.db_private_subnets_cidr)
  cidr_block              = element(var.db_private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "db-subnet-${element(var.availability_zones, count.index)}-${var.environment}-environment"
  }
}

/*==== Bastion Security Group ======*/
resource "aws_security_group" "bastions_sg" {
  name        = "bastions-sg-${var.environment}-environment"
  description = "Bastion sg to allow inbound/outbound"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  // Block to create ingress rules
  dynamic "ingress" {
    iterator = port
    for_each = var.bastion_ingress_rule

    content {
      description = "Port ${port.value} rule"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  // Without this section no incoming connection from VPC
  egress {
    description = "Allow ALL Protocols outboud"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastions-sg-${var.environment}-environment"
  }
}

/*==== Private instances Security Group ======*/
#tfsec:ignore:aws-vpc-no-public-ingress-sgr
resource "aws_security_group" "private_instances_sg" {
  name        = "private-instances-sg-${var.environment}-environment"
  description = "Private instances sg to allow inbound/outbound"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  // Block to create ingress rules
  dynamic "ingress" {
    iterator = port
    for_each = var.private_instances_ingress_rule

    content {
      description = "Port ${port.value} rule"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = var.public_subnets_cidr
    }
  }

  ingress {
    description = "Port 53 UDP rule"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    //cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  // Without this section no incoming connection from VPC
  egress {
    description = "Allow ALL Protocols outboud"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
    // #tfsec:ignore:aws-vpc-no-public-egress-sg 
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-instance-sg-${var.environment}-environment"
  }
}

/*==== EKS Security Group ======*/
resource "aws_security_group" "eks_sg" {
  name        = "eks-sg-${var.environment}-environment"
  description = "EKS sg to allow inbound/outbound"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  # Inbound Rule
  ingress {
    description = "EKS Ingress rule"
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  ingress {
    description = "Traefik Ingress rule"
    from_port   = 30080
    to_port     = 30080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  ingress {
    description = "DNS UDP Rule"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  // Block to create ingress rules
  dynamic "ingress" {
    iterator = port
    for_each = var.eks_ingress_rule

    content {
      description = "Port ${port.value} rule"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      #tfsec:ignore:aws-vpc-no-public-ingress-sg 
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  // Without this section no incoming connection from VPC
  egress {
    description = "Allow ALL Protocols outboud"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    #tfsec:ignore:aws-vpc-no-public-egress-sg 
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name                                               = "eks-nodes-sg-${var.environment}-environment"
    "kubernetes.io/cluster/eks-${var.environment}-env" = "owned"
  }
}

/*==== RDS Security Group ======*/
resource "aws_security_group" "db_sg" {
  name        = "db-sg-${var.environment}-environment"
  description = "DB sg to allow inbound/outbound"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  // Block to create ingress rules
  dynamic "ingress" {
    iterator = port
    for_each = var.sg_db_rule

    content {
      description = "Port ${port.value} rule"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      // Allow connection only FROM private subnets
      cidr_blocks = var.private_subnets_cidr
    }
  }

  // Without this section no incoming connection from VPC
  egress {
    description = "Allow ALL Protocols outboud"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
    // Allow outbound only TO private subnets
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg-${var.environment}-environment"
  }
}

/*==== GitLab Runners Security Group ======*/
resource "aws_security_group" "gitlab_runners_sg" {
  name        = "gitlab-runners-sg-${var.environment}-environment"
  description = "GitLab Runners sg to allow inbound/outbound"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  // Block to create ingress rules
  dynamic "ingress" {
    iterator = port
    for_each = var.sg_gitlab_runners_rules

    content {
      description = "Port ${port.value} rule"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      // Allow connection only FROM private subnets
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  // Without this section no incoming connection from VPC
  egress {
    description = "Allow ALL Protocols outboud"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
    // Allow outbound only TO private subnets
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gitlab-runners-sg-${var.environment}-environment"
  }
}

/*==== ACL for Public subnet ======*/
resource "aws_network_acl" "acl_public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  depends_on = [aws_vpc.vpc, aws_subnet.public_subnet]
  count      = length(var.public_subnets_cidr)
  subnet_ids = ["${element(aws_subnet.public_subnet.*.id, count.index)}"]

  dynamic "ingress" {
    for_each = var.acl_public_subnet_rule.ingress_rule

    content {
      protocol   = "tcp"
      rule_no    = ingress.value.rule_no
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    #tfsec:ignore:aws-vpc-no-public-egress-sg
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name                                               = "Public subnet ACL in ${element(var.availability_zones, count.index)}"
    "kubernetes.io/cluster/eks-${var.environment}-env" = "owned"
  }
}

/*==== ACL for Private subnet ======*/
resource "aws_network_acl" "acl_private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  depends_on = [aws_vpc.vpc, aws_subnet.private_subnet]
  count      = length(var.private_subnets_cidr)
  subnet_ids = ["${element(aws_subnet.private_subnet.*.id, count.index)}"]

  dynamic "ingress" {
    for_each = var.acl_private_subnet_rule.ingress_rule
    content {
      protocol   = "tcp"
      rule_no    = ingress.value.rule_no
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  // THESE 2 RULES PERMIT DNS RESOLUTION
  // TO POD WHICH ARE NOT IN THE SAME NODE WHERE COREDNS IS
  ingress {
    protocol   = "udp"
    rule_no    = 201
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 53
    to_port    = 53
  }

  ingress {
    protocol   = "udp"
    rule_no    = 202
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65535
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    #tfsec:ignore:aws-vpc-no-public-egress-sg 
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "Private subnet ACL in ${element(var.availability_zones, count.index)}"
  }
}

/*==== ACL for DB subnet ======*/
resource "aws_network_acl" "acl_db_subnet" {
  vpc_id     = aws_vpc.vpc.id
  depends_on = [aws_vpc.vpc, aws_subnet.db_subnets]
  count      = length(var.db_private_subnets_cidr)
  subnet_ids = ["${element(aws_subnet.db_subnets.*.id, count.index)}"]

  dynamic "ingress" {
    for_each = var.acl_db_rule.ingress_rule
    content {
      protocol   = "tcp"
      rule_no    = ingress.value.rule_no
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    #tfsec:ignore:aws-vpc-no-public-egress-sg 
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "DB ACL in ${element(var.availability_zones, count.index)}"
  }
}

// get vpc peering id 
// filtering by name and status
/*data "aws_vpc_peering_connection" "peering_acceptance_prod" {
  filter {
    name   = "tag:Name"
    values = ["prod-to-prod-peering"]
  }
  status = "active"
}

// add route for vpc peering with cidr_block
resource "aws_route" "prod_to_prod" {
  count                     = length(var.db_private_subnets_cidr)
  route_table_id            = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block    = "20.0.0.0/16"
  vpc_peering_connection_id = data.aws_vpc_peering_connection.peering_acceptance_prod.id
}
*/
