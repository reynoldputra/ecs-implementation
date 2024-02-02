## cluster
resource "aws_ecs_cluster" "simple_shop_rest" {
  name = "simple_shop_rest"
}

## task definition
resource "aws_cloudwatch_log_group" "simple_shop_log" {
  name = "/ecs/simple-shop-log"
}

resource "aws_ecs_task_definition" "task_def_simple_shop" {
  family = "simple_shop_rest"

  execution_role_arn = var.aws_role_task_def_arn

  container_definitions = jsonencode([
    {
      "name" : "simple_shop_rest",
      "image" : var.image_url,
      "portMappings" : [
        {
          "containerPort" : var.port
        }
      ],
      "environment" : [
        { "name" : "PORT", "value" : "5000" }
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
  name            = "simple_shope"
  task_definition = aws_ecs_task_definition.task_def_simple_shop.arn
  cluster         = aws_ecs_cluster.simple_shop_rest.id
  launch_type     = "FARGATE"

  network_configuration {
    assign_public_ip = true

    security_groups = var.sec_groups
    subnets         = var.subnets
  }
}
