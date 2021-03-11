# Create a bucket

resource "aws_s3_bucket" "b1" {
  bucket = "s3bucket-creation-from-jenkins-pipeline"
  acl    = "private"

  tags = {
    Name        = "Mybucket"
    Environment = "PROD"
  }
}

# Upload an object 

resource "aws_s3_bucket_object" "object" {
    for_each = fileset("myfiles/", "*")
   bucket = aws_s3_bucket.b1.id
  key    = each.value
  source = "myfiles/${each.value}"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("myfiles/${each.value}")
}
