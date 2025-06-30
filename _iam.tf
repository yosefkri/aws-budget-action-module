resource "aws_iam_role" "role" {
  for_each = local.iam_roles

  name = "${var.budget_name}-${each.key}-role"
  assume_role_policy = each.value["assume_role_policy"]
}

resource "aws_iam_role_policy" "policies" {
  for_each = { for i in local.policies_calculations: i["name"] => i }

  name = "${var.budget_name}-${each.key}-policy"
  role = aws_iam_role.role[each.value["role"]].id
  policy = each.value["policy"]
}