/* 
 * This module is used to create a IAM Lens account for dev and prod environment
 *
 *    
 *
 * These are the accounts created
 *
 * - Lens_User_dev_Env
 * - Lens_User_prod_Env
*/

// Create Lens user
resource "aws_iam_user" "lens_user" {
  name = "Lens_User_${var.environment}_Env"
}

// Attach policies for Lens
resource "aws_iam_user_policy_attachment" "attach_cluster_policies_to_user" {
  depends_on = [aws_iam_user.lens_user]
  user       = aws_iam_user.lens_user.name
  policy_arn = "arn:aws:iam::848481299679:policy/viewNodeWorkload${var.environment}Env"
}