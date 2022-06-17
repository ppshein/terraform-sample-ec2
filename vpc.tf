resource "aws_vpc" "main" {
  cidr_block           = var.vpc.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = var.vpc.enable_dns_hostnames
  tags                 = local.common_tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = local.common_tags
}

resource "aws_subnet" "main" {
  depends_on = [
    aws_vpc.main
  ]
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc.aws_subnet_cidr
  availability_zone = var.vpc.availability_zone
  tags              = merge(local.common_tags, { Name = "subnet-a" })
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = merge(local.common_tags, { Name = "public-rt" })
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}
