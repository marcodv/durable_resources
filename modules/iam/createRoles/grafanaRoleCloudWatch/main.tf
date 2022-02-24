/* 
 * This module is used to create IAM Cloudwatch roles for dev and prod environment
 *
 * This Role is used from Grafana to access to the metrics and show them
 *
 * To each role are assigned different IAM accounts
 *
 * These are the roles created
 *
 * - grafanaRoleCloudWatchdevEnv
 * - grafanaRoleCloudWatchprodEnv
*/

// Create Grafana Role for prod env
resource "aws_iam_role" "iam_role_grafana" {
  name               = var.grafana_role
  assume_role_policy = file("${path.module}/grafanaRoleCloudWatch${var.environment}Env.json")
}

// Create aws billing viewer policy for grafana
resource "aws_iam_policy" "read_only_billing_policy" {
  depends_on  = [aws_iam_role.iam_role_grafana]
  name        = var.read_only_billing_policy
  path        = "/"
  description = "Policy to read cloudwatch metrics for Grafana"
  policy      = file("${path.module}/${var.read_only_billing_policy}.json")
}

// Attach CUSTOMER policy to worker node role
resource "aws_iam_role_policy_attachment" "aim_customer_policy_attachment_worker_node" {
  depends_on = [aws_iam_role.iam_role_grafana, aws_iam_policy.read_only_billing_policy]
  role       = aws_iam_role.iam_role_grafana.name
  policy_arn = "arn:aws:iam::848481299679:policy/${aws_iam_policy.read_only_billing_policy.name}"
}
