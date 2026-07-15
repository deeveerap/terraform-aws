resource "aws_s3_bucket" "wordpress_bucket" {
  bucket = "xfusion-s3-16049"
}

resource "aws_s3_bucket_acl" "wordpress_bucket_acl" {
  bucket = aws_s3_bucket.wordpress_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket" "wordpress_bucket_new" {
  bucket = var.KKE_BUCKET
}

resource "aws_s3_bucket_acl" "wordpress_bucket_acl_new" {
  bucket = aws_s3_bucket.wordpress_bucket_new.id
  acl    = "private"
}

resource "null_resource" "move_s3_objects" {
  # Triggers a rerun every time, remove or change this if it should only run once
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "aws s3 cp s3://${aws_s3_bucket.wordpress_bucket.bucket} s3://${aws_s3_bucket.wordpress_bucket_new.bucket} --recursive"
  }
}
