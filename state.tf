terraform {
  backend "s3" {
    bucket = "pgr301bucket"
    key    = "fRrmQiPHih/terraform.tfstate"
    region = "eu-north-1"
  }
}