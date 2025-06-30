# AWS Budget Actions

This Terraform project implements AWS Budget with automated actions when budget thresholds are reached. The solution applies Service Control Policies (SCPs) to restrict resource usage when budget thresholds are exceeded.

## Architecture Overview

The solution uses AWS Budgets to monitor costs and automatically apply Service Control Policies (SCPs) to organizational units when budget thresholds are reached.

## Features

1. **Budget Threshold Monitoring**: Configurable thresholds for budget notifications and actions
2. **Service Control Policy**: Automatically applies restrictive SCPs when high thresholds are reached
3. **Email Notifications**: Sends email alerts at different budget thresholds

## Components

- **AWS Budget**: Monitors costs and sends notifications when thresholds are reached
- **AWS Budget Actions**: Applies SCP policies when budget thresholds are exceeded
- **IAM Roles**: Provides necessary permissions for budget actions

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed
- AWS Organizations access for SCP management
- S3 bucket for storing Terraform state and plan files

## Configuration

Edit the `terraform.tfvars` file with your specific values:

```hcl
region                = "xxx"
budget_name           = "sandbox"
scp_id                = "xxx"
ou_ids                = ["ou-xxx"]
linked_account_ids    = ["xxx"]
budget_amount         = 100
budget_threshould     = {
  low = {
    threshold = 70
    subscriber_email_addresses = ["xxx@xxx.xxx"]
  }
  medium = {
    threshold = 80
    subscriber_email_addresses = ["xxx@xxx.xxx"]
  }
  high = {
    threshold = 95
    subscriber_email_addresses = ["xxx@xxx.xxx"]
  }
  block = {
    threshold = 100
    block = true
    subscriber_email_addresses = ["xxx@xxx.xxx"]
  }
}
linked_account_ids    = ["xxx"]  # Optional: Filter budget by specific accounts
```

## Variables

| Variable | Description |
|----------|-------------|
| `target_role` | The IAM role to assume for budget actions |
| `region` | AWS region to deploy the solution |
| `budget_threshould` | Map of budget thresholds with notification settings |
| `budget_name` | Name prefix for the budget |
| `budget_amount` | The monthly budget amount in USD |
| `scp_id` | The Service Control Policy ID to attach when budget is exceeded |
| `ou_ids` | List of Organization Unit IDs to apply the SCP to |
| `linked_account_ids` | (Optional) List of AWS account IDs to filter the budget by |

## Deployment

1. Initialize Terraform:

```bash
terraform init
```

2. Review the plan:

```bash
terraform plan
```

3. Apply the configuration:

```bash
terraform apply
```

## Customization

### Modifying the Budget Thresholds

Edit the `budget_threshould` variable in `terraform.tfvars` to customize the thresholds and actions.

### Filtering by Linked Accounts

Add the `linked_account_ids` variable to filter the budget to specific AWS accounts.

## Monitoring

Monitor the solution using:

- AWS Budgets dashboard
- Email notifications at configured thresholds

## Cleanup

To remove all resources created by this solution:

```bash
terraform destroy
```

## Security Considerations

- IAM roles follow the principle of least privilege
- Budget actions require explicit configuration
- Email notifications provide early warning of approaching thresholds
