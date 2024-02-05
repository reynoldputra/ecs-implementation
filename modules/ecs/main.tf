## cluster
resource "aws_ecs_cluster" "simple_shop_rest" {
  name = "simple_shop_rest"
}

## task definition
resource "aws_cloudwatch_log_group" "simple_shop_log" {
  name = "/ecs/simple-shop-log"
}

resource "aws_ecs_task_definition" "task_def_simple_shop" {
  family = "simple-shop"

  execution_role_arn = var.aws_role_task_def_arn

  container_definitions = jsonencode([
    {
      "image" : "${var.image_url}:latest",
      "name" : "simple-shop",
      "portMappings" : [
        {
          "containerPort" : var.port
        }
      ],
      "environment" : [
        { "name" : "PORT", "value" : "5000" },
        { "name" : "HOST", "value" : "0.0.0.0" }
      ],
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-region" : "ap-southeast-1a",
          "awslogs-group" : aws_cloudwatch_log_group.simple_shop_log.name,
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
  ])

  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
}


## service
resource "aws_ecs_service" "simple_shop" {
  name            = "simple-shop"
  task_definition = aws_ecs_task_definition.task_def_simple_shop.arn
  cluster         = aws_ecs_cluster.simple_shop_rest.id
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    assign_public_ip = false

    security_groups = var.sec_groups
    subnets         = var.subnets
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "simple-shop"
    container_port   = 5000
  }

  depends_on = [aws_ecs_task_definition.task_def_simple_shop]
}
