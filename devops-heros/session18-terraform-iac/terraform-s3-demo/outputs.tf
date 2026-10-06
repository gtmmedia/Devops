output "bucket_name" {
  type        = string
  description = "Name of the S3 bucket."
<<<<<<< HEAD
  value       = aws_s3_bucket.gtm007.bucket
=======
  value       = aws_s3_bucket.devops553.bucket
>>>>>>> 8376590a668ac8d6f2700d181c0739d0ed3fc5ea
}
output "bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket."
<<<<<<< HEAD
  value       = aws_s3_bucket.gtm007.arn
=======
  value       = aws_s3_bucket.devops553.arn
>>>>>>> 8376590a668ac8d6f2700d181c0739d0ed3fc5ea
}
output "bucket_region" {
  type        = string
  description = "AWS region of the S3 bucket."
<<<<<<< HEAD
  value       = aws_s3_bucket.gtm007.region
=======
  value       = aws_s3_bucket.devops553.region
>>>>>>> 8376590a668ac8d6f2700d181c0739d0ed3fc5ea
}
