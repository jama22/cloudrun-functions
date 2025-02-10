provider "google" {
  project = var.project_id
}

resource "google_cloud_run_v2_service" "default" {
  name     = var.function_name
  location = var.function_location
  client   = "terraform"
  template {
    containers {
      name = var.function_name
      image = var.function_image
      base_image_uri = var.base_image
      resources {
        limits = {
          cpu    = var.run_cpu
          memory = var.run_memory
        }
      }
    }
  }
  
  build_config{
    function_target = var.function_target
    image_uri = var.function_image
    base_image = var.base_image
    enable_automatic_updates = true
  }
}

resource "google_cloud_run_v2_service_iam_member" "noauth" {
  location = google_cloud_run_v2_service.default.location
  name     = google_cloud_run_v2_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
