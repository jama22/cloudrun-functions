variable "project_id" {
 type = string
 default = ""
 description = "The GCP project ID"
}

variable "bucket_id" {
 type = string
 default = ""
 description = "The id of the storage bucket where your function source will be uploaded"
}

variable "bucket_location" {
 type = string
 default = ""
 description = "The GCP region where your GCS bucket will be created"
}

variable "function_files" {
  type = map(string)
  default = {}
  description = "A map of the function files and their dependencies. This will be uploaded to Cloud Storage. Key is the path to the file on your local path, and value is the destination path"
}

variable "function_name" {
 type = string
 default = ""
 description = "The name of your function"
}

variable "function_location" {
 type = string
 default = ""
 description = "The GCP region where your function will be deployed"
}

variable "function_entrypoint" {
 type = string
 default = ""
 description = "The entrypoint for your function"
}

variable "function_image" {
 type = string
 default = ""
 description = "The path to your function container image"
}

variable "run_cpu" {
  type = string
  default = "1"
  description = "The amount of CPU on your Run service"
}

variable "run_memory" {
  type = string
  default = "512Mi"
  description = "he amount of memory on your Run service"
}