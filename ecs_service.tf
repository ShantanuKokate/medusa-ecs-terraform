# ecs_service.tf

resource "aws_ecs_service" "medusa_service" {
  name            = "medusa-service"
  cluster         = "${aws_ecs_cluster.medusa_cluster.id}"
  task_definition = "${aws_ecs_task_definition.medusa_task.arn}"
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = ["subnet-xxxxxxxx"]  # Replace with your subnet ID
    security_groups = ["${aws_security_group.medusa_sg.id}"]
  }
}

