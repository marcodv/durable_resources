resource "aws_iam_policy" "tf_remote_state_backend_user_policies" {
  for_each    = { for k, v in var.access_tf_backend_policies : k => v }
  name        = each.value.name
  path        = each.value.path
  description = each.value.description
  policy      = file("${path.module}/${each.value.name}.json")
}

resource "aws_iam_policy" "cutom_policies_user" {
  for_each    = { for k, v in var.custom_policies_list : k => v }
  name        = each.value.name
  path        = each.value.path
  description = each.value.description
  policy      = file("${path.module}/${each.value.name}.json")
}

