terraform {
  #  bucket para armazenar o state do terraform,
  backend "s3" {
    bucket = "terraform-state-soat7-fiap-shinitii"
    key    = "Prod/terraform.tfstate"
    region = "us-east-1"
  }
}

