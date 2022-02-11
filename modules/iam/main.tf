// EKS ALB Ingress policy 
/*resource "aws_iam_policy" "alb_controller_policy" {
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
} */
