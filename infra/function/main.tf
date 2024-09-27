provider "google" {
  project = var.project_id
}

resource "google_storage_bucket" "functions" {
 name          = var.bucket_id
 location      = var.bucket_location
 storage_class = "STANDARD"

 uniform_bucket_level_access = true
}
resource "google_storage_bucket_object" "my-function-objects" {
  for_each = var.function_files
  name     = each.value
  source   = "${path.module}/${each.key}"
  bucket   = google_storage_bucket.functions.id
}

resource "google_cloud_run_v2_service" "default" {
  name     = var.function_name
  location = var.function_location
  client   = "terraform"
  template {
    containers {
      image = var.function_image
      resources {
        limits = {
          cpu    = var.run_cpu
          memory = var.run_memory
        }
      }
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "noauth" {
  location = google_cloud_run_v2_service.default.location
  name     = google_cloud_run_v2_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
