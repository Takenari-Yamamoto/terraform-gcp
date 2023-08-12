provider "google" {
  credentials = file("../.credentials/key.json")
  project     = var.project_id
  region      = var.default_region
}

resource "google_cloud_run_service" "sample-app-001" {
  name     = "sample-app-001"
  location = var.default_region

  template {
    spec {
      containers {
        image = "asia.gcr.io/${var.project_id}/sample-app-001"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

