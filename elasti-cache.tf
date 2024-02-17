resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "robo-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.t3.medium"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.pg.name
  engine_version       = "6.x"
  port                 = 6379
  security_group_ids   = [aws_security_group.allow-redis.id]
  subnet_group_name    = aws_elasticache_subnet_group.redis-subnet_group.name
}

# Creates Parameter group
resource "aws_elasticache_parameter_group" "pg" {
  name   = "robo-${var.ENV}-redis-pg"
  family = "redis6.x"
}

#Creates Subnet Group.
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "robo-${var.ENV}-redis-subnet_group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID
}


