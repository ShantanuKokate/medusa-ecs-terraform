# ecs_task_definition.tf

resource "aws_ecs_task_definition" "medusa_task" {
  family                   = "medusa-task"
  execution_role_arn       = "${aws_iam_role.ecs_task_execution_role.arn}"
  task_role_arn            = "${aws_iam_role.ecs_task_role.arn}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([{
    name      = "medusa-backend"
    image     = "medusajs/medusa:latest"  # Replace with your ECR image if needed
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [
      {
        containerPort = 9000
        hostPort      = 9000
      }
    ]
  }])
}

