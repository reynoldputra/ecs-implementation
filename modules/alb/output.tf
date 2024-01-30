output "alb_url" {
  value = "http://${aws_alb.simple_shop.dns_name}"
}
