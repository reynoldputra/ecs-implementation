resource "aws_alb" "simple_shop" {
  name               = "simple-shop"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = var.sec_groups

  depends_on = [var.aws_alb_dependencies]
}

resource "aws_alb_target_group" "alb_target_simple_shop" {
  name        = "simple-shop-target"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  depends_on = [aws_alb.simple_shop]
}

resource "aws_alb_listener" "simple_shop_http" {
  load_balancer_arn = aws_alb.simple_shop.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_simple_shop.arn
  }
}
