resource "aws_s3_bucket" "bucket-stack" {
  count = length(var.bucket_names)
  bucket = "${var.project_name}-${var.bucket_names[count.index]}-${var.environment}-${terraform.workspace}"
  force_destroy = true

  tags = {
    Name        = "${var.project_name}-${var.bucket_names[count.index]}-${var.environment}-${terraform.workspace}"
    Environment = var.environment
    Cost_Center = "TI"
    project_name = var.project_name
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket-encryption" {
  count = length(var.bucket_names)
  bucket = "${var.project_name}-${var.bucket_names[count.index]}-${var.environment}-${terraform.workspace}"

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

# resource "aws_s3_bucket_acl" "bucket-acl" {
#   count = length(var.bucket_names)
#   bucket = "${var.project_name}-${var.bucket_names[count.index]}-${var.environment}-${terraform.workspace}"
#   acl    = "private"
# }

resource "aws_s3_bucket_public_access_block" "bucket-public-1" {
  count = length(var.bucket_names)
  bucket = "${var.project_name}-${var.bucket_names[count.index]}-${var.environment}-${terraform.workspace}"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}