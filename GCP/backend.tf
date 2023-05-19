terraform {
  backend "gcs" {
    bucket  = "backend-terraform-stack"
    prefix  = "terraform/state"
    credentials = "stack-terraform-couse-da236c699e81.json"
  }
}
