variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "s3-by-github-action"

}