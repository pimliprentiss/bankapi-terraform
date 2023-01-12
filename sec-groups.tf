resource "aws_security_group" "cluster_workers" {
  name_prefix = "cluster_workers"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr]

  }
}