data "http" "appliances" {
  url = var.marketplace
  request_headers = {
    User-Agent = "OpenNebula 6.10.0"
    Accept     = "application/json"
  }
}

locals {
  appliances = {
    for a in jsondecode(data.http.appliances.response_body).appliances : a.name => a
  }

  name = "Service OneKE ${var.OneKE_version}"

  service = local.appliances[local.name]

  roles = {
    for k, v in local.service.roles : k => merge(local.appliances[v], {
      opennebula_template = jsondecode(local.appliances[v].opennebula_template)
    })
  }

  md5_to_url = {
    for f in distinct(flatten([
      for r in values(local.roles) : concat(
        try(r.files, []),
        [for d in try(r.disks, []) : local.appliances[d].files]
      )
    ])) : f.md5 => f.url
  }

  role_to_md5 = {
    for k, v in local.roles : k => [
      for f in flatten(concat(
        try(v.files, []),
        [for d in try(v.disks, []) : local.appliances[d].files]
      )) : f.md5
    ]
  }
}
