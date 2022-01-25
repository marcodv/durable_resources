// Create policy for EKS ALB Ingress
resource "aws_iam_policy" "alb_controller_policy" {
  name        = var.alb_ingress_controller.name
  path        = var.alb_ingress_controller.path
  description = var.alb_ingress_controller.description
  policy      = file("${path.module}/alb-controller-eks.json")
}
