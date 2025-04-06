# ecs-cluster.tf

resource "aws_ecs_cluster" "medusa_cluster" {
  name = "medusa-cluster"
}

