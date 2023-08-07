provider "google" {
  project = "wide-link-393311"
  region = "europe-central2"
  credentials = "/var/lib/jenkins/terraform/wide-link-393311-0fe1368e354c.json"
}
resource "google_container_cluster" "test" {
  name = "test-cluster"
  location = "europe-central2"
  enable_autopilot = true
}
resource "google_container_cluster" "prod" {
  name = "prod-cluster"
  location = "europe-central2"
  enable_autopilot = true
}
