variable "region"                     { description = "Region to deploy the solution" }
variable "budget_threshould"          { description = "Threshoulds" }
variable "budget_name"                { default = "budget" }
variable "budget_amount"              { description = "The monthly amount budget" }
variable "scp_id"                     { description = "The SCP id we want to attach" }
variable "ou_ids"                     { description = "The list of effected ou's when budget limit reached" }
variable "linked_account_ids"         { description = "Accounts to be monitored" }
