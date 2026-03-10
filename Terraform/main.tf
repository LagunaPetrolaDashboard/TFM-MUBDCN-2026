terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# 1. Definimos el nombre del bucket (DEBE SER ÚNICO EN TODO AWS)
# Te recomiendo poner tus iniciales o un número al final
resource "aws_s3_bucket" "mi_db_bucket" {
  bucket = "tfm-almacen-muestras-agua-2026" 
}

# 2. Subimos el archivo SQLite directamente a la raíz del bucket
resource "aws_s3_object" "archivo_db" {
  bucket = aws_s3_bucket.mi_db_bucket.id
  key    = "Petrola.db"                   # Nombre que tendrá en S3
  source = "../Dashboard_TFM/Database/Petrola.db"  # Ruta local de tu archivo
  
  # Esta línea asegura que si el archivo cambia localmente, Terraform lo detecte y lo vuelva a subir
  etag = filemd5("../Dashboard_TFM/Database/Petrola.db")
}

# 3. Output para ver la URL del archivo al terminar
output "s3_uri" {
  value = "s3://${aws_s3_bucket.mi_db_bucket.id}/${aws_s3_object.archivo_db.key}"
}