# AWS Budget with actions
resource "aws_budgets_budget" "cost_budget" {
  name              = "${var.budget_name}-monthly-cost-budget"
  budget_type       = "COST"
  limit_amount      = var.budget_amount
  limit_unit        = "USD"
  time_unit         = "MONTHLY"

  # Filter by linked accounts if specified
  dynamic "cost_filter" {
    for_each = length(var.linked_account_ids) > 0 ? [1] : []
    content {
      name   = "LinkedAccount"
      values = var.linked_account_ids
    }
  }

  # Email notifications only (no SNS)
  dynamic "notification" {
    for_each = try(var.budget_threshould, {})
    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = notification.value["threshold"]
      threshold_type             = "PERCENTAGE"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = length(try(notification.value["subscriber_email_addresses"], [])) > 0 ? notification.value["subscriber_email_addresses"] : null
    }
  }
}

# Apply SCP action when budget reaches high threshold
resource "aws_budgets_budget_action" "apply_scp" {
  for_each           = { for key,val in var.budget_threshould: key => val if try(val["block"], false) == true }
  budget_name        = aws_budgets_budget.cost_budget.name
  action_type        = "APPLY_SCP_POLICY"
  approval_model     = "AUTOMATIC"
  notification_type  = "ACTUAL"
  execution_role_arn = aws_iam_role.role["budget-actions"].arn

  action_threshold {
    action_threshold_type  = "PERCENTAGE"
    action_threshold_value = each.value["threshold"]
  }

  definition {
    scp_action_definition {
      policy_id  = var.scp_id
      target_ids = var.ou_ids
    }
  }

  subscriber {
    address           = each.value["subscriber_email_addresses"][0]
    subscription_type = "EMAIL"
  }
}
