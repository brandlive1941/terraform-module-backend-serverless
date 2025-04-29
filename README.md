# terraform-module-backend-serverless
terraform module for creating cloud run back ends to attach to load balancers

Module Input Variables
----------------------

- `project` - gcp project id
- `name` - identifier for the backend
- `cloud_run_services` - cloud run services to region map
- `enable_public` - enable/disable ingress to service from anywhere
- `enable_cdn` - enable/disable cdn
- `iap_config` - iap config
- `log_config` - log config

Usage
-----

```hcl
module "example-lb" {
  source          = "github.com/brandlive1941/terraform-module-backend-serverless?ref=v1.0.1"

  project_id         = var.project_id
  name               = each.key
  cloud_run_services = each.value["cloud_run_regions"]
  enable_public      = each.value["enable_public"]
  enable_cdn         = each.value.backend["enable_cdn"]
  iap_config         = each.value.backend["iap_config"]
  log_config         = each.value.backend["log_config"]
}
```

Outputs
=======

Contributing
=======
This project uses [Commitizen](https://commitizen-tools.github.io/commitizen/).

Use the following command to stage a release after adding files with `git commit`
  ```bash
  git cz
  ```
This will guide you through a series of prompts to format your commit message correctly.

This only needs to be done once per PR

Authors
=======

drew.mercer@brandlive.com