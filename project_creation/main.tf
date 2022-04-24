# Create a project for Compute Engine
resource "google_project" "project" {
  name            = var.prefix
  project_id      = var.prefix
  billing_account = var.billing_account
  org_id          = var.org_id
}

# Enable the required services on the project
resource "google_project_service" "service" {
  for_each = toset(var.services)

  service = each.key

  project            = google_project.project.project_id
  disable_on_destroy = false
}