import {
  to = opennebula_user.oneadmin
  id = 0
}

resource "opennebula_user" "oneadmin" {
  name           = "oneadmin"
  password       = var.one_password
  ssh_public_key = var.ssh_public_key

  lifecycle { ignore_changes = [password, name] }
}
