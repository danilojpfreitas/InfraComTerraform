terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
    }
  }
}

provider "google" {
  project     = "stack-terraform.json"
  region      = "us-central1"
}