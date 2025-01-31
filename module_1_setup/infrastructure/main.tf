terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.18.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  credentials = file(var.gcp_srvc_accnt_creds_terraform)
}

resource "google_storage_bucket" "dezc25-bucket" {
  name          = var.gcs_bucket_id
  location      = var.location
  force_destroy = true
  storage_class = var.gcs_storage_class

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "dezc25-bq-dataset" {
  dataset_id = var.bq_dataset_id
  location   = var.location
}