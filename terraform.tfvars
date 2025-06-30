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
