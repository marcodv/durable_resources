/* 
 * This module is used to create a IAM terraform account for dev and prod environment
 *
 * To each account are assigned different IAM custom and AWS policies
 *    
 *
 * These are the accounts created
 *
 * - Terraform_User_Dev_Env
 * - Terraform_User_Prod_Env
*/

// Create tf user
resource "aws_iam_user" "iam_user" {
  name = var.iam_user_name
}

// Create policies for access to S3/DynamoDB as tf state file backend
resource "aws_iam_policy" "custom_policies_user" {
  depends_on  = [aws_iam_user.iam_user]
  for_each    = { for k, v in var.terraform_user_access_backend_list_policies : k => v }
  name        = each.value.name
  path        = each.value.path
  description = each.value.description
  policy      = file("${path.module}/${each.value.name}.json")
}

// Attach policies for access to S3/DynamoDB as tf state file backend
resource "aws_iam_user_policy_attachment" "attach_custom_policies_to_user" {
  depends_on = [aws_iam_user.iam_user]
  user       = var.iam_user_name
  for_each   = { for k, v in var.terraform_user_access_backend_list_policies : k => v }
  policy_arn = "arn:aws:iam::848481299679:policy/${each.value.name}"
}

// Attach needed policies to tf user
resource "aws_iam_user_policy_attachment" "attach_managed_policies_to_user" {
  depends_on = [aws_iam_user.iam_user]
  user       = var.iam_user_name
  count      = length(var.aws_managed_policies_list)
  policy_arn = "arn:aws:iam::aws:policy/${element(var.aws_managed_policies_list, count.index)}"
}
