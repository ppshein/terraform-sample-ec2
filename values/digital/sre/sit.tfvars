provider_role = "[provider-role]" #provider role will be replaced here
business_unit = "digital"
project       = "sre"
environment   = "sit"

vpc = {
  availability_zone    = "ap-southeast-1a"
  aws_subnet_cidr      = "10.2.1.0/24"
  cidr_block           = "10.2.0.0/16"
  enable_dns_hostnames = false
  name                 = "ppshein-vpc"
}

ec2 = {
  instance_type     = "t2.micro"
  name              = "ppshein"
  os_type           = "linux"
  volume_size       = 20
  volume_type       = "gp3"
  pem_key           = "terraform.pem"
  availability_zone = "ap-southeast-1a"
}

security_groups = [{
  from_port   = 22
  name        = "Office Wifi SSH"
  protocol    = "tcp"
  to_port     = 22
  cidr_blocks = ["0.0.0.0/0"] # you can replace with your office wifi outbount IP range
  }, {
  from_port   = 80
  name        = "Nginx Port"
  protocol    = "tcp"
  to_port     = 80
  cidr_blocks = ["0.0.0.0/0"]
}]
