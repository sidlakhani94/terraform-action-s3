#AWS S3 Configuration.

#Creating S3 Bucket.

resource "aws_s3_bucket" "mys3-bucket" {
  bucket = var.s3_bucket
}

#Grant public access.

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.mys3-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.mys3-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "my_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ownership,
    aws_s3_bucket_public_access_block.public_access,
  ]

  bucket = aws_s3_bucket.mys3-bucket.id
  acl    = "public-read"
}


#Enabling Static website hosting.

resource "aws_s3_bucket_website_configuration" "website-host" {
  bucket = aws_s3_bucket.mys3-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

#Attach Bucket Policy.

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.mys3-bucket.id
  policy = <<EOF
{
  "Id": "Policy1687949727949",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1687949725493",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.pixibytez-bucket.arn}/*",
      "Principal": "*"
    }
  ]
}
EOF
}