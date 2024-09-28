variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "project_location" {
  type        = string
  default     = "us-central1"
  description = "GCP region"
}

variable "secret_id" {
  type        = string
  description = "Secret Manager ID"
}

variable "secret_sa" {
  type        = string
  description = "Secret Manager SA"
}

variable "build_connector_name" {
  type        = string
  description = "Name of the Cloud Build connector"
}

variable "build_trigger_name" {
  type        = string
  description = "Name of the Cloud Build trigger"
}

variable "build_config_path" {
  type        = string
  default     = "couldbuild.yaml"
  description = "Path to the Cloud Build config in the repo"
}

variable "github_pat" {
  type        = string
  description = "GitHub personal access Token"
}

variable "github_app_installation_id" {
  type        = number
  description = "GitHub Cloud Build application installation ID"
}

variable "github_repo_name" {
  type        = string
  description = "Name of your GitHub repo"
}

variable "github_repo_uri" {
  type        = string
  description = "GitHub repo address in HTTPS"
}

variable "github_branch" {
  type        = string
  default     = "main"
  description = "GitHub branch to trigger"
}
