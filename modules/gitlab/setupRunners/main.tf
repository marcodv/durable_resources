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


// Read secret for prod secrets
data "aws_secretsmanager_secret" "runner_token" {
  name = var.registration_token
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.runner_token.id
}

locals {
  aux_token = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["gitlab_token"]
}

module "gitlab-runner" {
  source  = "npalm/gitlab-runner/aws"
  version = "4.41.1"
  ## Section about networking config
  aws_region                            = var.aws_region
  vpc_id                                = data.aws_vpc.vpc.id
  environment                           = "${var.environment}-${var.gitlab_project}-gitlab-runners"
  subnet_ids_gitlab_runner              = data.aws_subnet_ids.private_subnet.ids
  subnet_id_runners                     = element(tolist(data.aws_subnet_ids.private_subnet.ids), 0)
  extra_security_group_ids_runner_agent = [data.aws_security_group.gitlab_runners_sg.id]

  ## Section about instance runners config 
  log_group_name      = "${var.environment}-${var.gitlab_project}-gitlab-runners-logs"
  metrics_autoscaling = var.metrics_autoscaling
  runners_name        = "${var.environment}-gitlab-runner-${var.gitlab_project}"
  runners_gitlab_url  = var.runner_parameters.gitlab_url

  runners_token              = local.aux_token
  instance_type              = var.runner_parameters.instance_type
  runner_instance_spot_price = var.runner_parameters.runner_instance_spot_price
  enable_runner_ssm_access   = true

  docker_machine_download_url   = var.docker_machine_paramenters.url_download
  docker_machine_spot_price_bid = var.docker_machine_paramenters.spot_price_bid
  docker_machine_instance_type  = var.docker_machine_paramenters.instance_type
  agent_tags = {
    "tf-aws-gitlab-runner:instancelifecycle" = "spot:yes"
  }

  tags = {
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
  ami_owners = [var.ami_owners]
  ami_filter = {
    "name" : ["ami-gitlab-runner-template"]
  }

  gitlab_runner_version = "14.10.0"
  ## Section about scaling options 
  # working 9 to 5
  enable_asg_recreation = true
  enable_schedule       = true
  runners_machine_autoscaling = [
    {
      periods      = ["\"* * 0-10,17-23 * * mon-fri *\"", "\"* * * * * sat,sun *\""]
      idle_count   = 0
      idle_time    = 60
      runner_token = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["gitlab_token"]
      gitlab_url   = var.runner_parameters.gitlab_url
      timezone     = "Europe/Amsterdam"
    }
  ]

  cache_bucket = {
    create = "false"
    bucket = var.gitlab_bucket_name
    policy = ""
  }

  // Register runners in a non interactive mode
  userdata_post_install = join("", [
    "sudo gitlab-runner register --non-interactive --url 'https://gitlab.com/' ",
    " --registration-token ${local.aux_token}",
    " --description ${var.runner_parameters.description}-${var.gitlab_project} --executor 'docker' ",
    " --docker-image ${var.docker_machine_paramenters.image_version} --tag-list ${var.gitlab_project},${var.environment} ",
    " --run-untagged=true --locked=true",
    " && /usr/bin/gitlab-runner verify"
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
