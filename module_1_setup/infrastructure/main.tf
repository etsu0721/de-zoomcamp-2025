terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.18.0"
    }
  }
}

provider "google" {
  project = "data-engineering-zoomcamp-25"
  region  = "us-central1"
}

resource "google_storage_bucket" "dezc25-bucket" {
  name          = "dezc25-bucket-i6qwkb77ncd4wa"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}