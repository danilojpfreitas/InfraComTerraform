###################### CONFIGURA O PROVIDER ###########################
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  credentials = "stack-terraform-couse-da236c699e81.json"
  region      = "us-central1"
}