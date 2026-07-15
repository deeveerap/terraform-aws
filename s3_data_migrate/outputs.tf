output "new_kke_bucket_name" {
  value = aws_s3_bucket.wordpress_bucket_new.bucket
}

output "new_kke_bucket_acl" {
  value = aws_s3_bucket_acl.wordpress_bucket_acl_new.acl
}
