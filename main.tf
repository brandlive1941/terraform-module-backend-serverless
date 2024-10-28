locals {
  public_services = var.public ? var.cloud_run_services : [{}]
  cloud_run_services = {
    for service in var.cloud_run_services :
    "${var.name}-${service.region}" => {
      "name"   = service.name
      "region" = service.region
    }
  }
  backend = {
    name       = var.name
    enable_cdn = var.enable_cdn
    log_config = var.log_config
    groups = [
      for service in local.cloud_run_services :
      {
        group = google_compute_region_network_endpoint_group.serverless_neg["${var.name}-${service.region}"].id
      }
    ]
    iap_config = var.iap_config
  }
}

data "google_cloud_run_v2_service" "service" {
  for_each = local.cloud_run_services

  name     = each.value["name"]
  location = each.value["region"]
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  provider              = google-beta
  for_each              = local.cloud_run_services
  name                  = "${var.name}-neg"
  network_endpoint_type = "SERVERLESS"
  region                = each.value["region"]
  project               = var.project_id
  cloud_run {
    service = each.value["name"]
  }
}



resource "google_cloud_run_service_iam_binding" "public" {
  for_each = local.cloud_run_services
  location = data.google_cloud_run_v2_service.service[each.key].location
  service  = data.google_cloud_run_v2_service.service[each.key].name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}