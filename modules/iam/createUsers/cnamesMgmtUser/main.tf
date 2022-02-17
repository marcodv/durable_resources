/* 
 * This module is used to create a IAM User account for manage CNAMEs records binded to HubSpot landing pages
 *
 * This account only need to have route53 permissions in order to create and update CNAMEs records
 *    
 *
 * This is the account created
 *
 * - landing_pages_cname_records_user_mgmt
 * 
*/


// This create the user for IAM with permission policy
resource "aws_iam_user" "cname_mgmt_user" {
  name = var.user_name_mgmt_landing_page
}

// Create policies for Django Users create/update cnames records
resource "aws_iam_policy" "cname_mgmt_user_policy" {
  depends_on  = [aws_iam_user.cname_mgmt_user]
  name        = "${var.cnames_landing_pages_mgmt_policy_name}"
  path        = "/"
  description = "Policy used user ${var.user_name_mgmt_landing_page} in order to create/update CNAME records"
  policy      = file("${path.module}/cnameRecordsMgmt.json")
}

// Attach policies created before to each django user
resource "aws_iam_user_policy_attachment" "attach_custom_policies_to_user" {
  depends_on = [aws_iam_policy.cname_mgmt_user_policy]
  user       = aws_iam_user.cname_mgmt_user.name
  policy_arn = "arn:aws:iam::848481299679:policy/${aws_iam_policy.cname_mgmt_user_policy.name}"
}
