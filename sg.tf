## Creates Security Group 
resource "aws_security_group" "allow-redis" {
 name        = "robo-${var.ENV}-redis-sg"
 description = "Allows Redis Internal inbound traffic"
 vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID 
 
ingress {
   description = "Allows redis from local network"
   from_port   = 6379
   to_port     = 6379
   protocol    = "tcp"
   cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
 }

ingress {
   description = "Allows redis from default network"
   from_port   = 6379
   to_port     = 6379
   protocol    = "tcp"
   cidr_blocks = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

tags = {
    Name = "allow-redis"
  }
}


