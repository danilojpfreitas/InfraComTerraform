####### Terraform - Integracao com GCP ####

########## BigQuery ##########

###### CRIAR DATASET stack ##### 
resource "google_bigquery_dataset" "dataset_stack" {
  dataset_id    = "data_plataform_stack"
  friendly_name = "data_plataform_stack"
  description   = "Data Plataform - stack data processing SFTP"
  location      = var.location
  project = var.project
}

#### TABLE stack - TABLE EXTERNA ####
resource "google_bigquery_table" "table_stack_01" {
  dataset_id  = google_bigquery_dataset.dataset_stack.dataset_id
  table_id    = "data_plataform_stack_processed"
  description = "Tabela com dados processado SFTP stack"
  project = var.project
  deletion_protection = false

  external_data_configuration {
    autodetect    = true
    source_format = "CSV"

    source_uris = [
      "gs://stack-terraform-couse-stack-curated-production/fhvhv_tripdata_2022-04.parquet"
    ]
  }
}