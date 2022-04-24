
variable "billing_account" {
  type        = string
  description = "Billing account"
}

variable "org_id" {
  type        = string
  description = "Organization ID"
}
variable "region" {
  type        = string
  description = "Default region"
  default     = "us-central1"
}

variable "prefix" {
  type        = string
  description = "Prefix for naming in the project"
}

variable "services" {
  type = list(string)
  description = "List of services need to enable for project"
  default = [
    "compute.googleapis.com",
    "appengine.googleapis.com",
    "appengineflex.googleapis.com",
    "cloudbuild.googleapis.com",
    "secretmanager.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}