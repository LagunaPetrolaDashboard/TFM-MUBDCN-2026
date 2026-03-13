###############################################################################
##################### CREACIÓN Y CARPETAS BUCKET S3 ###########################
###############################################################################

# Creación del Bucket
resource "aws_s3_bucket" "medallion_lake" {
  bucket = "tfm-petrola-data-lake"

  tags = {
    Project     = "TFM Petrola"
    Environment = "Dev"
  }
}


# Bloqueo de Acceso Público al S3
resource "aws_s3_bucket_public_access_block" "protection" {
  bucket = aws_s3_bucket.medallion_lake.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Cifrado de los archivos almacenados
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.medallion_lake.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Creación de las carpetas de landing y medallion y sus subcarpetas
resource "aws_s3_object" "folders" {
  for_each = toset(["landing/", "medallion/bronce/", "medallion/silver/", "medallion/gold/", "medallion/quarantine/", "medallion/references/"])
  
  bucket  = aws_s3_bucket.medallion_lake.id
  key     = each.value
  content = ""
}