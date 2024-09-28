// Configure the terraform google provider
provider "google" {
  project = var.project_id
}

// Create a secret containing the personal access token and grant permissions to the Service Agent
resource "google_secret_manager_secret" "github_token_secret" {
  project   = var.project_id
  secret_id = var.secret_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "github_token_secret_version" {
  secret      = google_secret_manager_secret.github_token_secret.id
  secret_data = var.github_pat
}

data "google_iam_policy" "serviceagent_secretAccessor" {
  binding {
    role    = "roles/secretmanager.secretAccessor"
    members = [var.secret_sa]
  }
}

resource "google_secret_manager_secret_iam_policy" "policy" {
  project     = google_secret_manager_secret.github_token_secret.project
  secret_id   = google_secret_manager_secret.github_token_secret.secret_id
  policy_data = data.google_iam_policy.serviceagent_secretAccessor.policy_data
}

// Create the GitHub connection
resource "google_cloudbuildv2_connection" "my_connection" {
  project  = var.project_id
  location = var.project_location
  name     = var.build_connector_name

  github_config {
    app_installation_id = var.github_app_installation_id
    authorizer_credential {
      oauth_token_secret_version = google_secret_manager_secret_version.github_token_secret_version.id
    }
  }
  depends_on = [google_secret_manager_secret_iam_policy.policy]
}

resource "google_cloudbuildv2_repository" "my_repository" {
  name              = var.github_repo_name
  parent_connection = google_cloudbuildv2_connection.my_connection.id
  remote_uri        = var.github_repo_uri
}

resource "google_cloudbuild_trigger" "repo_trigger" {
  name     = var.build_trigger_name
  location = var.project_location

  repository_event_config {
    repository = google_cloudbuildv2_repository.my_repository.id
    push {
      branch = var.github_branch
    }
  }

  filename = var.build_config_path
}
