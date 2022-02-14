/* 
 * This module is used to create a IAM Cluster roles for dev and prod environment
 *
 * To each role are assigned different IAM accounts
 *  
 * Each role have managed and custom policies  
 *
 * These are the roles created
 *
 * - eks-role-dev-env
 * - eks-role-prod-env
*/

// Create EKS cluster role for test and prod env
resource "aws_iam_role" "iam_role_eks_cluster" {
  //change name cluster role
  name               = "eks-role-${var.environment}-env"
  assume_role_policy = file("${path.module}/EksClusterRolePolicy.json")
}

// Create Policies for EKS cluster
resource "aws_iam_policy" "iam_cluster_role_policies" {
  depends_on  = [aws_iam_role.iam_role_eks_cluster]
  for_each    = { for k, v in var.eks_cluster_role_policies : k => v }
  name        = each.value.name
  path        = each.value.path
  description = each.value.description
  policy      = file("${path.module}/${each.value.name}.json")
} 

// This block attach AWS policies to the cluster role
resource "aws_iam_role_policy_attachment" "aws_managed_policies_attachment_eks" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  count      = length(var.iam_aws_eks_policies)
  role       = "eks-role-${var.environment}-env"
  policy_arn = "arn:aws:iam::aws:policy/${element(var.iam_aws_eks_policies, count.index)}"
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
// This block attach CUSTOMER created policies to the cluster role
resource "aws_iam_role_policy_attachment" "aws_custom_policies_attachment_eks" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  count      = length(var.iam_customer_eks_policies)
  role       = "eks-role-${var.environment}-env"
  policy_arn = "arn:aws:iam::848481299679:policy/${element(var.iam_customer_eks_policies, count.index)}${var.environment}Env"
}
