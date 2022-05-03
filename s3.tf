resource "aws_s3_bucket" "logs" {
  bucket        = "${lower(var.name)}-logs"
  force_destroy = var.force_destroy

  tags = {
    Name = "${lower(var.name)}-logs"
  }

}


resource "aws_s3_bucket_acl" "logs" {
  bucket = aws_s3_bucket.logs.id
  acl    = "private"
}

resource "aws_s3_bucket" "blobs" {
  bucket        = "${lower(var.name)}-blobs"
  force_destroy = var.force_destroy

  tags = {
    Name = "${lower(var.name)}-blobs"
  }

}

resource "aws_s3_bucket_acl" "blobs" {
  bucket = aws_s3_bucket.blobs.id
  acl    = "private"
}


resource "aws_s3_bucket" "backups" {
  bucket        = "${lower(var.name)}-backups"
  force_destroy = var.force_destroy

  tags = {
    Name = "${lower(var.name)}-backups"
  }

}

resource "aws_s3_bucket_acl" "backups" {
  bucket = aws_s3_bucket.backups.id
  acl    = "private"
}


resource "aws_s3_bucket" "registry" {
  bucket        = "${lower(var.name)}-registry"
  force_destroy = var.force_destroy

  tags = {
    Name = "${lower(var.name)}-registry"
  }

}

resource "aws_s3_bucket_acl" "registry" {
  bucket = aws_s3_bucket.registry.id
  acl    = "private"
}


data "aws_iam_policy_document" "s3_bucket_access" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads"
    ]
    resources = [
      "arn:aws:s3:::${lower(var.name)}-backups",
      "arn:aws:s3:::${lower(var.name)}-blobs",
      "arn:aws:s3:::${lower(var.name)}-logs",
      "arn:aws:s3:::${lower(var.name)}-registry"
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload"
    ]
    resources = [
      "arn:aws:s3:::${lower(var.name)}-backups",
      "arn:aws:s3:::${lower(var.name)}-blobs",
      "arn:aws:s3:::${lower(var.name)}-logs",
      "arn:aws:s3:::${lower(var.name)}-registry"
    ]
  }

}


resource "aws_iam_policy" "s3_bucket_access" {
  name   = "${var.name}-nodes-s3-bucket-access"
  policy = data.aws_iam_policy_document.s3_bucket_access.json
}
