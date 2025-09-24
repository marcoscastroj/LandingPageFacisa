variable "project_id" {
  description = "O ID do seu projeto no GCP."
  type        = string
}

variable "bucket_name" {
  description = "O nome único global para o bucket do Cloud Storage."
  type        = string
  # Nomes de bucket no GCP devem ser únicos globalmente!
  default     = "landing-page-facisa-2025-exemplo" # MUDE PARA UM NOME ÚNICO!
}

# Cria o bucket no Google Cloud Storage
resource "google_storage_bucket" "website_bucket" {
  name          = var.bucket_name
  project       = var.project_id
  location      = "US-CENTRAL1" # Pode escolher outra região
  force_destroy = true          # Facilita a destruição para testes

  website {
    main_page_suffix = "index.html"
  }
}

# Libera o acesso público para que todos possam ver os objetos (o site)
resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.website_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Saída com a URL pública do bucket
output "website_url" {
  value = "https://storage.googleapis.com/${google_storage_bucket.website_bucket.name}/index.html"
}