resource "opennebula_image" "oneke" {
  for_each     = local.md5_to_url
  name         = "${local.name} ${each.key}"
  datastore_id = 1
  persistent   = false
  permissions  = 642
  dev_prefix   = "vd"
  driver       = "qcow2"
  path         = each.value
}

resource "opennebula_template" "oneke" {
  for_each = local.roles
  name     = "${local.name} ${each.key}"
  cpu      = try(each.value["opennebula_template"].CPU, null)
  vcpu     = try(each.value["opennebula_template"].VCPU, null)
  memory   = try(each.value["opennebula_template"].MEMORY, null)
  context  = try(each.value["opennebula_template"].CONTEXT, null)

  dynamic "graphics" {
    for_each = try([each.value["opennebula_template"].GRAPHICS], [])
    content {
      type   = try(graphics.value.TYPE, null)
      listen = try(graphics.value.LISTEN, null)
    }
  }

  dynamic "os" {
    for_each = try([each.value["opennebula_template"].OS], [])
    content {
      arch = try(os.value.ARCH, null)
      boot = "disk0"
    }
  }

  dynamic "disk" {
    for_each = local.role_to_md5[each.key]
    content {
      image_id = opennebula_image.oneke[disk.value].id
    }
  }
}

resource "opennebula_service_template" "oneke" {
  name        = local.name
  permissions = 642
  uname       = var.one_user
  gname       = var.one_user
  template = jsonencode({ "TEMPLATE" = { "BODY" = merge(
    jsondecode(local.service["opennebula_template"]),
    {
      "roles" : [
        for r in jsondecode(local.service["opennebula_template"]).roles : merge(
          r,
          { vm_template = tonumber(opennebula_template.oneke[r.name].id) }
        )
      ]
    }
  ) } })
}
