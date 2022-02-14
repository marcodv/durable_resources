/* 
 * This module is used create S3 bucket for app in dev,staging and prod environment
 *
 * Each of the environments have 1 public and 1 private bucket
 *
 * These are the buckets created
 *
 * - django-private-bucket-dev-env
 * - django-private-bucket-stage-env
 * - django-private-bucket-prod-env
 * - django-public-bucket-dev-env
 * - django-public-bucket-stage-env
 * - django-public-bucket-prod-env
*/

// Block required in order to use versioning for buckets
// Terraform issue 
// https://github.com/hashicorp/terraform-provider-aws/issues/23106
terraform {
  required_providers {
    aws = "~> 3.74"
  }
}

// Create Django public bucket
resource "aws_s3_bucket" "django_public_buckets" {
  count  = length(var.django_public_buckets)
  bucket = element(var.django_public_buckets, count.index)

  versioning {
    enabled = true
  }
}

// Create Django private buckets
resource "aws_s3_bucket" "django_private_buckets" {
  count  = length(var.django_private_buckets)
  bucket = element(var.django_private_buckets, count.index)

  versioning {
    enabled = true
  }
}

// Block public access to private Django buckets
resource "aws_s3_bucket_public_access_block" "django_private_buckets_acl" {
  count                   = length(var.django_public_buckets)
  bucket                  = element(aws_s3_bucket.django_private_buckets.*.id, count.index)
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
