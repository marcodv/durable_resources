/* 
 * This module is used to create a IAM GitLab Users for dev and prod environment
 *
 * These users are needed in order to execute pipeline on Spot instances 
 *
 * and store logs on S3
 *    
 *
 * These are the accounts created
 *
 * - Gitlab_User_Dev_Env
 * - Gitlab_User_Prod_Env
*/

// Create Gitlab user
resource "aws_iam_user" "gitlab_user" {
  name = var.gitlab_user
}

// Create policy for Gitlab Users to access to buckets
resource "aws_iam_policy" "gitlab_policy" {
  depends_on  = [aws_iam_user.gitlab_user]
  name        = "bucketPolicyGitLab${var.environment}Env"
  path        = "/"
  description = "GitLab user policy for ${var.environment}"
  policy      = templatefile("${path.module}/s3LogsRunnersPolicy.tpl", { bucketLogsPipelineGitlab = var.gitlab_bucket_name })
}

// Attach EC2 full access to Gitlab users for manage autoscaling 
// spot instances 
resource "aws_iam_user_policy_attachment" "gitlab_ec2_policy_attachment" {
  depends_on = [aws_iam_user.gitlab_user]
  user       = aws_iam_user.gitlab_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

// Attach CUSTOMER policy to Gitlab users for store pipeline logs
resource "aws_iam_user_policy_attachment" "gitlab_s3_policy_attachment" {
  depends_on = [aws_iam_user.gitlab_user]
  user       = aws_iam_user.gitlab_user.name
  policy_arn = "arn:aws:iam::848481299679:policy/${aws_iam_policy.gitlab_policy.name}"
}
