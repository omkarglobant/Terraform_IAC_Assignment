terraform {
  backend "s3" {
    bucket  = "terraform-backend-june-2025"
    key     = "dev/terraform.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}