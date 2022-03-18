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
    Name = "vpc-durable-prod-rds"
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.db_private_subnets_cidr)

  tags = {
    Name = "route-table-PROD-POSTGRES-${element(var.availability_zones, count.index)}"
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
    Name = "db-subnet-PROD-POSTGRES-${element(var.availability_zones, count.index)}"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.db_private_subnets_cidr)
  subnet_id      = element(aws_subnet.db_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

/*==== RDS Security Group ======*/
resource "aws_security_group" "db_sg" {
  name        = "db-sg-prod-environment"
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
    Name = "SG DB for prod environment"
  }
}

// get vpc id for vpc peering
data "aws_vpc" "vpc_prod_infra" {
  filter {
    name   = "tag:Name"
    values = ["vpc-prod-environment"]
  }
}

// get vpc peering id 
// filtering by name and status
data "aws_vpc_peering_connection" "peering_acceptance_prod" {
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

/*
resource "aws_route" "prod_to_dev" {
  count                     = length(var.db_private_subnets_cidr)
  route_table_id            = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block    = "30.0.0.0/16"
  vpc_peering_connection_id = data.aws_vpc_peering_connection.peering_acceptance.id
} */
