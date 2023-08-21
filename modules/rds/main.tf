######### aurora db subnet group #########
resource "aws_db_subnet_group" "bb-db-subnet-group" {
  name       = "bb-db-subnet-group"
  subnet_ids = var.private_subnet_ids
}


######### Aurora #########
resource "aws_kms_key" "bb-prd-kms" {
  description = "Example KMS Key"
  deletion_window_in_days = 10
}

resource "aws_rds_cluster_instance" "bb_cluster_instances" {
  count              = 3
  identifier         = "bb-aurora-cluster-${count.index}"
  cluster_identifier = aws_rds_cluster.bb-prd-rds-cluster.id
  instance_class     = "db.r5.large"
  engine             = aws_rds_cluster.bb-prd-rds-cluster.engine
  engine_version     = aws_rds_cluster.bb-prd-rds-cluster.engine_version
  performance_insights_enabled = true
  performance_insights_kms_key_id = aws_kms_key.bb-prd-kms.arn
}

resource "aws_rds_cluster" "bb-prd-rds-cluster" {
  cluster_identifier = "bb-aurora-cluster-demo"
  db_subnet_group_name = aws_db_subnet_group.bb-db-subnet-group.name
  availability_zones = ["ap-northeast-2a", "ap-northeast-2c", "ap-northeast-2b"]
  engine             = "aurora-postgresql"
  engine_version     = "14.6"
  database_name      = "mydb"
  master_username    = "foo"
  master_password    = "qwer1234!!"
  skip_final_snapshot = true
}