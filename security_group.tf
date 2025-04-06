# security_group.tf

resource "aws_security_group" "medusa_sg" {
  name        = "medusa-sg"
  description = "Allow Medusa ECS access"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

