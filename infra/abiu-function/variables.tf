variable "project_id" {
 type = string
 default = ""
 description = "The GCP project ID"
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

variable "function_target" {
 type = string
 default = ""
 description = "The target for your function"
}

variable "function_image" {
 type = string
 default = ""
 description = "The path to your function container image"
}

variable "base_image" {
 type = string
 default = ""
 description = "The path to the base image you want to use"
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