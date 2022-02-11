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
<<<<<<< HEAD
}

// Policy for worker node to manage EBS volume
resource "aws_iam_policy" "worker_node_manage_ebs_volume_policy" {
  name        = var.worker_node_manage_ebs_volume.name
  path        = var.worker_node_manage_ebs_volume.path
  description = var.worker_node_manage_ebs_volume.description
  policy      = file("${path.module}/EFSClusterPolicy.json")
}

// Create EKS cluster role for test and prod env
resource "aws_iam_role" "iam_role_eks_cluster" {
  name               = "eks-role-${var.environment}-env"
  assume_role_policy = file("${path.module}/EksClusterRolePolicy.json")
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
// This block attach CUSTOMER created policies to the cluster role
resource "aws_iam_role_policy_attachment" "aws_customer_policies_attachment_eks" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  count      = length(var.iam_customer_eks_policies)
  role       = "eks-role-${var.environment}-env"
  policy_arn = "arn:aws:iam::848481299679:policy/${element(var.iam_customer_eks_policies, count.index)}${var.environment}Env"
}

// This block attach AWS policies to the cluster role
resource "aws_iam_role_policy_attachment" "aws_managed_policies_attachment_eks" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  count      = length(var.iam_aws_eks_policies)
  role       = "eks-role-${var.environment}-env"
  policy_arn = "arn:aws:iam::aws:policy/${element(var.iam_aws_eks_policies, count.index)}"
}

// Worker node role 
resource "aws_iam_role" "iam_role_worker_node" {
  name               = var.worker_node_role
  assume_role_policy = file("${path.module}/worker-node-role.json")
}

// Attach AWS policy to worker node role
resource "aws_iam_role_policy_attachment" "aim_managed_policy_attachment_worker_node" {
  depends_on = [aws_iam_role.iam_role_worker_node]
  count      = length(var.aim_aws_worker_node_policies)
  role       = aws_iam_role.iam_role_worker_node.name
  policy_arn = "arn:aws:iam::aws:policy/${element(var.aim_aws_worker_node_policies, count.index)}"
}

// Attach CUSTOMER policy to worker node role
resource "aws_iam_role_policy_attachment" "aim_customer_policy_attachment_worker_node" {
  depends_on = [aws_iam_role.iam_role_worker_node, aws_iam_policy.worker_node_manage_ebs_volume_policy]
  count      = length(var.customer_policy_worker_node)
  role       = aws_iam_role.iam_role_worker_node.name
  policy_arn = "arn:aws:iam::848481299679:policy/${element(var.customer_policy_worker_node, count.index)}"
}
=======
} */
>>>>>>> develop
