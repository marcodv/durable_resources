/* 
 * This module create S3 bucket for GitLab in order to 
 * 
 * store logs from the pipeline execution 
 *
 *
 * These are the buckets created
 *
 * - gitlab-runners-bucket-dev-env
 * - gitlab-runners-bucket-prod-env
*/

// Block required in order to use versioning for buckets
// Terraform issue 
// https://github.com/hashicorp/terraform-provider-aws/issues/23106
terraform {
  required_providers {
    aws = "~> 3.74"
  }
}

// Create Django private buckets
#tfsec:ignore:aws-s3-specify-public-access-block 
#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:ignore:aws-s3-enable-bucket-logging 
resource "aws_s3_bucket" "gitlab_bucket_name" {
  bucket = var.gitlab_bucket_name

}

// Block public access to private Django buckets
resource "aws_s3_bucket_public_access_block" "gitlab_bucket_name_acl" {
  bucket                  = aws_s3_bucket.gitlab_bucket_name.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

// Create bucket versioning
resource "aws_s3_bucket_versioning" "gitlab_bucket_versioning" {
  bucket = aws_s3_bucket.gitlab_bucket_name.id
  versioning_configuration {
    status = "Enabled"
  }
}