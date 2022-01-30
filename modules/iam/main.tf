// EKS ALB Ingress policy 
resource "aws_iam_policy" "alb_controller_policy" {
  name        = var.alb_ingress_controller.name
  path        = var.alb_ingress_controller.path
  description = var.alb_ingress_controller.description
  policy      = file("${path.module}/alb-controller-eks.json")
}

// EC2 Full Access policy for EKS related resources
resource "aws_iam_policy" "ec2_full_access_policy" {
  name        = var.ec2_full_access.name
  path        = var.ec2_full_access.path
  description = var.ec2_full_access.description
  policy      = file("${path.module}/EC2FullAccess.json")
}

// IAM Limited Access policy
resource "aws_iam_policy" "iam_limited_access_policy" {
  name        = var.iam_limited_access.name
  path        = var.iam_limited_access.path
  description = var.iam_limited_access.description
  policy      = file("${path.module}/IamLimitedAccess.json")
}

// EKS All Access
resource "aws_iam_policy" "eks_all_access_policy" {
  name        = var.eks_all_access.name
  path        = var.eks_all_access.path
  description = var.eks_all_access.description
  policy      = file("${path.module}/EksAllAccess.json")
}

// Create IAM Role for ALB ingress controller for test and prod cluster
/*resource "aws_iam_role" "alb_ingress_role" {
  depends_on = [aws_iam_policy.alb_controller_policy]
  count = length(var.alb_ingress_controller_role_env)
  name  = element(var.alb_ingress_controller_role_env, count.index)
  description = "Role used by ALB ingress controller"
  path = "/"
  assume_role_policy = file("${path.module}/EksAlbRolePolicy.json")
}

// Attach ALB Policy for ALB role 
resource "aws_iam_role_policy_attachment" "alb_role_attachment" {
  depends_on = [aws_iam_role.alb_ingress_role]
  count = length(var.alb_ingress_controller_role_env)
  policy_arn = "arn:aws:iam::848481299679:policy/AWSLoadBalancerControllerIAMPolicy"
  role = "aws_iam_role.alb_ingress_role.${element(var.alb_ingress_controller_role_env, count.index)}"
} */

// Create EKS cluster role for test and prod env
resource "aws_iam_role" "iam_role_eks_cluster" {
  name               = "eks-role-${var.environment}-env"
  assume_role_policy = file("${path.module}/EksClusterRolePolicy.json")
}