variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "provider_role" {
  type = string
}

variable "business_unit" {
  type        = string
  description = "The name of the business unit."
}

variable "project" {
  type        = string
  description = "The name of the project."
}

variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "ubuntu_ami" {
  description = "ubuntu ami"
  type        = string
  default     = "ami-04ff9e9b51c1f62ca"
}

variable "linux_ami" {
  description = "linux ami"
  type        = string
  default     = "ami-0c802847a7dd848c0"
}

# declare Network layer attribute here
variable "vpc" {
  description = "The attribute of VPC information"
  type = object({
    name                 = string
    cidr_block           = string
    aws_subnet_cidr      = string
    availability_zone    = string
    enable_dns_hostnames = bool
  })
}


# declare EC2 attribute here
variable "ec2" {
  description = "The attribute of EC2 information"
  type = object({
    name              = string
    os_type           = string
    instance_type     = string
    volume_size       = number
    volume_type       = string
    pem_key           = string
    availability_zone = string
  })
}

variable "security_groups" {
  description = "The attribute of security_groups information"
  type = list(object({
    name        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
