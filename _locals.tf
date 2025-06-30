# Logics
locals {
  # IAM ROLES
  iam_roles = {
    budget-actions = {
      assume_role_policy = templatefile("${path.module}/policies/trust_policy.json", { SERVICE_NAME = "budgets.amazonaws.com" })
      policies = {
        scp = templatefile("${path.module}/policies/scp_attach_deattach.json", {})
      }
    }
  }
  # Calculate the number of policies to create based on the policies located under the roles policies
  policies_calculations = flatten([for role_name, role_config in local.iam_roles : [for policy_name, policy_value in role_config.policies : {name = "${role_name}-${policy_name}", policy = policy_value, role = role_name}]])
  
}


