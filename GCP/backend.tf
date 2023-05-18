terraform {
  backend "gcs" {
    bucket  = "backend-terraform-stack"
    prefix  = "terraform/state"
    credentials = "stack-terraform.json"
  }
}
