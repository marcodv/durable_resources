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
// add ignore tfsec for public access
// this bucket is public and hence ignore the warning
#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-no-public-access-with-acl
#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:ignore:aws-s3-specify-public-access-block 
resource "aws_s3_bucket" "django_public_buckets" {
  count  = length(var.django_public_buckets)
  bucket = element(var.django_public_buckets, count.index)
  acl    = "public-read"
  versioning {
    enabled = true
  }
}

// Create a bucket policies for full anonimous access 
resource "aws_s3_bucket_policy" "policy_django_public_bucket" {
  depends_on = [
    aws_s3_bucket.django_public_buckets
  ]
  count  = length(var.django_public_buckets)
  bucket = element(var.django_public_buckets, count.index)
  policy = templatefile("${path.module}/policyPublicBucket.tpl", { djangoBucketNamePublic = "${element(var.django_public_buckets, count.index)}" })
}

// Create Django private buckets
#tfsec:ignore:aws-s3-specify-public-access-block 
#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:ignore:aws-s3-enable-bucket-logging 
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
