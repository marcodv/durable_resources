resource "aws_iam_policy" "cutom_policies_user" {
  for_each    = { for k, v in var.custom_policies_list : k => v }
  name        = each.value.name
  path        = each.value.path
  description = each.value.description
  policy      = file("${path.module}/${each.value.name}.json")
}

resource "aws_iam_user" "iam_user" {
  depends_on = [aws_iam_policy.cutom_policies_user]
  name       = var.iam_user_name
}

resource "aws_iam_user_policy_attachment" "attach_custom_policies_to_user" {
  depends_on = [aws_iam_user.iam_user]
  user       = var.iam_user_name
  for_each   = { for k, v in var.custom_policies_list : k => v }
  policy_arn = "arn:aws:iam::848481299679:policy/${each.value.name}"
}

resource "aws_iam_user_policy_attachment" "attach_managed_policies_to_user" {
  depends_on = [aws_iam_user.iam_user]
  user       = var.iam_user_name
  count      = length(var.aws_managed_policies_list)
  policy_arn = "arn:aws:iam::aws:policy/${element(var.aws_managed_policies_list, count.index)}"
}

