variable "gcp_srvc_accnt_creds_terraform" {
  description = "GCP Service Account credentials for Terraform"
  default = "./keys/terraform-srvc-accnt-creds.json"
}

variable "project" {
  description = "Project name"
  default     = "data-engineering-zoomcamp-25"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "region" {
  description = "Region ID"
  default     = "us-central1"
}

variable "gcs_bucket_id" {
  description = "Storage Bucket ID"
  default     = "dezc25-bucket-i6qwkb77ncd4wa"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

variable "bq_dataset_id" {
  description = "BigQuery Dataset ID"
  default     = "dezc25_bq_dataset_qbmxo8y742f8pm"
}