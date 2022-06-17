resource "aws_key_pair" "deployer" {
  key_name   = "terraform"
  public_key = file("files/${var.ec2.pem_key}")
}

resource "aws_security_group" "sg" {
  description = "test sg for terraform"
  vpc_id      = aws_vpc.main.id
  depends_on = [
    aws_vpc.main,
    aws_subnet.main
  ]

  ingress {
    description = "Laptop Outbount IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.laptop_outbound_ip.body)}/32"]
  }

  dynamic "ingress" {
    for_each = var.security_groups
    content {
      description = ingress.value["name"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.common_tags, { Name = "internetfacing-sg" })
}

resource "aws_instance" "instance" {
  depends_on = [
    aws_security_group.sg
  ]
  ami                         = var.ec2.os_type == "linux" ? var.linux_ami : var.ubuntu_ami
  availability_zone           = var.ec2.availability_zone
  instance_type               = var.ec2.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.main.id
  key_name                    = aws_key_pair.deployer.id

  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = var.ec2.volume_size
    volume_type           = var.ec2.volume_type
  }

  user_data = file("templates/${var.ec2.os_type}.sh")
  tags      = merge(local.common_tags, { Name = var.ec2.name })
}
