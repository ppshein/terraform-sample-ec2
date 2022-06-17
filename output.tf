output "nginx_url" {
  value = "http://${aws_instance.instance.public_ip}"
}
