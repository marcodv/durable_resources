/* 
 * This module is used to create a IAM Worker Node roles for dev and prod environment
 *
 * To each role are assigned different IAM accounts
 *  
 * Each role have managed and custom policies  
 *
 * These are the roles created
 *
 * - WorkerNodeRoledevEnv
 * - WorkerNodeRoleprodEnv
*/

// Worker node role 
resource "aws_iam_role" "iam_role_worker_node" {
  name               = var.worker_node_role
  assume_role_policy = file("${path.module}/worker-node-role.json")
}

// Create Hosted zone policy
resource "aws_iam_policy" "list_hosted_zone_policy" {
  name        = var.manage_hosted_zone_policy
  path        = "/"
  description = "Policy to list hosted zone for workerNodeRole"
  policy      = file("${path.module}/${var.manage_hosted_zone_policy}.json")
}

// Attach AWS policy to worker node role
resource "aws_iam_role_policy_attachment" "iam_managed_policy_attachment_worker_node" {
  depends_on = [aws_iam_role.iam_role_worker_node]
  count      = length(var.iam_aws_worker_node_policies)
  role       = aws_iam_role.iam_role_worker_node.name
  policy_arn = "arn:aws:iam::aws:policy/${element(var.iam_aws_worker_node_policies, count.index)}"
}

// Attach CUSTOMER policy to worker node role
resource "aws_iam_role_policy_attachment" "aim_customer_policy_attachment_worker_node" {
  depends_on = [aws_iam_role.iam_role_worker_node, aws_iam_policy.list_hosted_zone_policy]
  count      = length(var.customer_policy_worker_node)
  role       = aws_iam_role.iam_role_worker_node.name
  policy_arn = "arn:aws:iam::848481299679:policy/${element(var.customer_policy_worker_node, count.index)}"
}
