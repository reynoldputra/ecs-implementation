output "alb_url" {
  value = "http://${aws_alb.simple_shop.dns_name}"
}

output "alb_target_group_arn" {
  value = aws_alb_target_group.alb_target_simple_shop.arn
}
