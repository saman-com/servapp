variable "billing_account" {
  type        = string
  description = "Billing account"
  default     = "01A9EE-F11DB3-936FF0"
}

variable "org_id" {
  type        = string
  description = "Organization ID"
  default     = "342395548897"
}
variable "region" {
  type        = string
  description = "Default region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "Default zone"
  default     = "us-central1-a"
}

variable "prefix" {
  type        = string
  description = "Prefix for naming in the project"
  default     = "serv"
}

variable "network_name" {
  type        = string
  description = "VPC network Name"
  default     = "serv-network"
}

variable "subnet_ip" {
  type        = string
  description = "IP range for the subnet"
  default     = "10.10.10.0/24"
}
variable "subnet_name" {
  type        = string
  description = "Name for the subnet"
  default     = "serv-subnet"
}

variable "instance_name" {
  type        = string
  description = "The gce instance name"
  default     = "serv"
}

variable "target_size" {
  type        = number
  description = "The number of runner instances"
  default     = 1
}

variable "machine_type" {
  type        = string
  description = "The GCP machine type"
  default     = "n1-standard-1"
}

variable "source_image_family" {
  type        = string
  description = "Source image family. If neither source_image nor source_image_family is specified, defaults to the latest public Ubuntu image."
  default     = "ubuntu-minimal-2004-lts"
}

variable "source_image_project" {
  type        = string
  description = "Project where the source image comes from"
  default     = "ubuntu-os-cloud"
}

variable "source_image" {
  type        = string
  description = "Source disk image. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image."
  default     = ""
}

variable "cooldown_period" {
  description = "The number of seconds that the autoscaler should wait before it starts collecting information from a new instance."
  default     = 60
}

variable "database_version" {
    type = string
    description = "Database version for app"
    default = "POSTGRES_9_6"
}

variable "database_tier" {
    type = string
    description = "Database tier for app"
    default = "db-f1-micro"
}

variable "database_name" {
    type = string
    description = "Name of database for app"
    default = "serv"
}

# Random id for naming
resource "random_id" "id" {
  byte_length = 4
  prefix      = var.prefix
}

locals {
  gcp_service_account_name = "${var.prefix}-serv-app"
  cloud_sql_instance_name = "${random_id.id.hex}-db"
}