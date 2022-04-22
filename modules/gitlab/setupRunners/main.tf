/* 
 * This module is used to create an autoscaling group 
 *
 * of spot instances where runs task from GitLab 
 *  
 * Each group have managed and custom policies  
 *
 * These are the groups created
 *
 * - EKSClusterManagement
 *
 * Module explanation:
 * https://registry.terraform.io/modules/npalm/gitlab-runner/aws/latest?tab=inputs
*/

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["vpc-${var.environment}-environment"]
  }
}

data "aws_subnet_ids" "private_subnet" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = "private-subnet-*-${var.environment}-environment"
  }
}

data "aws_security_group" "gitlab_runners_sg" {
  filter {
    name   = "tag:Name"
    values = ["gitlab-runners-sg-${var.environment}-environment"]
  }
}

module "gitlab-runner" {
  source  = "npalm/gitlab-runner/aws"
  version = "4.41.1"
  ## Section about networking config
  aws_region                            = "eu-west-1"
  vpc_id                                = data.aws_vpc.vpc.id
  environment                           = "${var.environment}-gitlab-runners"
  subnet_ids_gitlab_runner              = data.aws_subnet_ids.private_subnet.ids
  subnet_id_runners                     = element(tolist(data.aws_subnet_ids.private_subnet.ids), 0)
  extra_security_group_ids_runner_agent = [data.aws_security_group.gitlab_runners_sg.id]
  // gitlab_runner_security_group_ids = [data.aws_security_group.gitlab_runners_sg.id]


  ## Section about instance runners config 
  log_group_name             = "${var.environment}-gitlab-runners-logs"
  metrics_autoscaling        = ["GroupDesiredCapacity", "GroupInServiceCapacity"]
  runners_name               = "${var.environment}-gitlab-runners"
  runners_gitlab_url         = "https://gitlab.com/"
  runners_token              = var.registration_token
  instance_type              = "t3.medium"
  runner_instance_spot_price = "0.0137"
  enable_runner_ssm_access   = true

  docker_machine_download_url   = "https://gitlab-docker-machine-downloads.s3.amazonaws.com/v0.16.2-gitlab.2/docker-machine"
  docker_machine_spot_price_bid = "0.0137"
  docker_machine_instance_type  = "t3.medium"
  agent_tags = {
    "gitlab-project"                         = "durable-aws-resources"
    "tf-aws-gitlab-runner:instancelifecycle" = "spot:yes"
  }

  /*
  gitlab_runner_registration_config = {
    registration_token = var.registration_token
    tag_list           = "${var.environment}-docker-runners , docker_spot_runner" // this tag used in CICD
    description        = "runner description"
    locked_to_project  = true
    run_untagged       = true
    maximum_timeout    = "100"
  } */

  tags = {
    "tf-aws-gitlab-runner:example"           = "runner-default"
    "tf-aws-gitlab-runner:instancelifecycle" = "spot:yes"
  }

  runners_privileged         = "true"
  runners_additional_volumes = ["/certs/client"]
  runners_volumes_tmpfs = [
    {
      volume  = "/var/opt/cache",
      options = "rw,noexec"
  }]
  runners_services_volumes_tmpfs = [
    {
      volume  = "/var/lib/mysql",
      options = "rw,noexec"
  }]

  ## AMI selection for spin up runners
  ami_owners = ["848481299679"]
  ami_filter = {
    "name" : ["ami-gitlab-runner-template"]
  }

  gitlab_runner_version = "14.10.0"
  ## Section about scaling options 
  # working 9 to 5
  enable_asg_recreation = true
  enable_schedule       = true
  runners_machine_autoscaling = [
    {
      periods      = ["\"* * 0-10,17-23 * * mon-fri *\"", "\"* * * * * sat,sun *\""]
      idle_count   = 5
      idle_time    = 60
      runner_token = var.registration_token
      gitlab_url   = "https://gitlab.com/"
      timezone     = "Europe/Amsterdam"
      # You can create ssh_key_pair in AWS & provide the name here
      //ssh_public_key = "ssh-key-bastion-${var.environment}-env"
    }
  ]

  cache_bucket = {
    create = "false"
    bucket = var.gitlab_bucket_name
    policy = ""
  }

  // Register runners in a non interactive mode
  userdata_post_install = join("", [
    "sudo gitlab-runner register --non-interactive --url 'https://gitlab.com/' --registration-token ${var.registration_token}",
    " --description 'runner-agent-test' --executor 'docker+machine' --docker-image 'docker:18.03.1-ce' --tag-list 'ec2-spot,durable-resources-aws' " ,
    " --run-untagged 'true' --locked 'true'",
    "&& /usr/bin/gitlab-runner verify" 
  ])
}

resource "null_resource" "cancel_spot_requests" {
  # Cancel active and open spot requests, terminate instances
  triggers = {
    environment = var.environment
  }

  provisioner "local-exec" {
    when    = destroy
    command = "../../bin/cancel-spot-instances.sh ${self.triggers.environment}"
  }
}
