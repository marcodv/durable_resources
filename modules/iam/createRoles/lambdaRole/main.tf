/* 
 * This module is used to create IAM Lambda roles for dev and prod environment
 *
 * This Role is used to make call to the Bubble backup script in Google App script
 *
 * To each role are assigned different IAM accounts
 *  
 * Each role have managed and custom policies  
 *
 * These are the roles created
 *
 * - lambdaRoleBubbleBackupprodEnv
 * - lambdaRoleDeleteBubbleBackup
*/

// Create Lambda Role for prod env
resource "aws_iam_role" "iam_role_lambda" {
  name               = var.lambda_role_bubble_backup
  assume_role_policy = file("${path.module}/lambdaRolePolicy${var.environment}Env.json")
}

// Create Lambda Role for prod env
resource "aws_iam_role" "iam_role_lambda_delete_backup" {
  name               = var.lambda_role_delete_bubble_backup
  assume_role_policy = file("${path.module}/lambdaRolePolicy${var.environment}Env.json")
}