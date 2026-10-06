<<<<<<< HEAD
resource "aws_s3_bucket" "gtm007" {
=======
resource "aws_s3_bucket" "devops553" {
>>>>>>> 8376590a668ac8d6f2700d181c0739d0ed3fc5ea
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    Name        = var.bucket_name
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "Session18"
  }
}
