/* 
 * This module is used to create a IAM Django app account for dev, stage and prod environment
 *
 * To each account are assigned different IAM bucket policies
 *    
 *
 * These are the accounts created
 *
 * - app_User_dev_Env
 * - app_User_stage_Env
 * - app_User_prod_Env
*/

// Create users for development, staging and production envs
resource "aws_iam_user" "iam_user" {
  for_each = { for k, v in var.application_users : k => v }
  name     = each.value.user_name
}

// Create policies for Django Users to access to private and public buckets
resource "aws_iam_policy" "custom_policies_user" {
  depends_on  = [aws_iam_user.iam_user]
  for_each    = { for k, v in var.application_users : k => v }
  name        = each.value.policy_name
  path        = "/"
  description = "Policy used by Django user ${each.value.user_name}"
  policy      = templatefile("${path.module}/DjangoBucketPolicy.tpl", { djangoBucketNamePublic = each.value.public_bucket, djangoBucketNamePrivate = each.value.private_bucket })
}

// Attach policies created before to each django user
resource "aws_iam_user_policy_attachment" "attach_custom_policies_to_user" {
  depends_on = [aws_iam_policy.custom_policies_user]
  user       = each.value.user_name
  for_each   = { for k, v in var.application_users : k => v }
  policy_arn = "arn:aws:iam::848481299679:policy/${each.value.policy_name}"
}