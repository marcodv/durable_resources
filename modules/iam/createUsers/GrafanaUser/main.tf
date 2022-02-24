/* 
 * This module is used to create a IAM terraform account for dev and prod environment
 *
 * To each account are assigned different IAM custom and AWS policies
 *    
 *
 * These are the accounts created
 *
 * - Grafana_User_Dev_Env
 * - Grafana_User_Prod_Env
*/

// Create grafana user
resource "aws_iam_user" "grafana_user" {
  name = var.grafana_user
}

// Attach CUSTOMER policy to worker node role
resource "aws_iam_user_policy_attachment" "aim_customer_policy_attachment_worker_node" {
  depends_on = [aws_iam_user.grafana_user]
  user       = aws_iam_user.grafana_user.name
  policy_arn = "arn:aws:iam::848481299679:policy/awsBillingPolicydevEnv"
}