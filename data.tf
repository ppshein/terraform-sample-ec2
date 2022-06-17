# All data source should be defined here resuable purpose

# To collect AWS IAM role/account information
data "aws_iam_account_alias" "current" {}

# To collect AWS Caller Identity information.
data "aws_caller_identity" "current" {}

# To collect AWS Region information
data "aws_region" "current" {}

data "http" "laptop_outbound_ip" {
  url = "http://ipv4.icanhazip.com"
}
