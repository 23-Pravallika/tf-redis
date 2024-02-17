resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "robo-${var.ENV}-redis"
  engine               = "redis"
  node_type            = var.REDIS_NODE_TYPE
  num_cache_nodes      = var.REDIS_NODE_COUNT
  parameter_group_name = aws_elasticache_parameter_group.pg.name
  engine_version       = var.REDIS_ENGINE_VERSION
  port                 = var.REDIS_PORT
  security_group_ids   = [aws_security_group.allow-redis.id]
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
}

# Creates Parameter group
resource "aws_elasticache_parameter_group" "pg" {
  name   = "robo-${var.ENV}-redis-pg"
  family = "redis${var.REDIS_ENGINE_VERSION}"
}

#Creates Subnet Group.
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "robo-${var.ENV}-redis-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID
}


