data "azurerm_client_config" "current" {}
data "azurerm_key_vault" "kv" {
  name                = "${var.resource_group_name}-k"
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "current" {
  name                 = var.subnet
  virtual_network_name = var.vnet
  resource_group_name  = var.resource_group_name
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
    subnet_id                     = data.azurerm_subnet.current.id
    private_ip_address            = var.ip_address
  }
}

resource "random_password" "password" {
  length  = 20
  special = true
}

resource "azurerm_key_vault_secret" "password" {
  name         = var.name
  value        = random_password.password.result
  key_vault_id = data.azurerm_key_vault.kv.id

  depends_on = [random_password.password]
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  zone                            = var.zone
  network_interface_ids           = [azurerm_network_interface.nic.id]
  admin_username                  = "adminuser"
  admin_password                  = random_password.password.result
  disable_password_authentication = false
  license_type = var.license_type

  os_disk {
    caching                = "ReadWrite"
    storage_account_type   = var.bootdisk_type
    disk_size_gb           = var.bootdisk_size
  }

  dynamic "source_image_reference" {
    for_each = var.image_id != null ? [] : [1]
    content {
      publisher = var.image.os_publisher
      offer     = var.image.os_offer
      sku       = var.image.os_sku
      version   = var.image.os_version
    }
  }

  source_image_id = var.image_id != null ? var.image_id : null

  dynamic "plan" {
    for_each = var.plan.os_publisher != null ? [1] : []
    content {
      publisher = var.plan.os_publisher
      product   = var.plan.os_offer
      name      = var.plan.os_sku
    }
  }

  boot_diagnostics {
    #When empty utilize a Managed Storage Account.
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  depends_on = [random_password.password]
}

resource "azurerm_managed_disk" "disk" {
  for_each = var.managed_disk

  name                   = "${var.name}-${each.value.name}"
  location               = var.location
  resource_group_name    = var.resource_group_name
  storage_account_type   = each.value.disk_type
  create_option          = "Empty"
  disk_size_gb           = each.value.disk_size
  zone                   = var.zone

  
  depends_on = [azurerm_linux_virtual_machine.vm]
}

resource "azurerm_virtual_machine_data_disk_attachment" "atch" {
  for_each = azurerm_managed_disk.disk

  managed_disk_id    = each.value.id
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun                = index(keys(azurerm_managed_disk.disk), each.key)
  caching            = "ReadWrite"

  depends_on = [azurerm_managed_disk.disk]
}

resource "azurerm_virtual_machine_extension" "disk_formatter" {
  count = azurerm_managed_disk.disk != {} ? 1 : 0

  name                 = "CustomScript"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1.1"
  protected_settings   = <<-PROTECTED_SETTINGS
  {
    "script": "IyEvYmluL2Jhc2gKCmhlbHAoKQp7CiAgICBlY2hvICJVc2FnZTogJChiYXNlbmFtZSAkMCkgWy1iIGRhdGFfYmFzZV0gWy1oXSBbLXNdIFstbyBtb3VudF9vcHRpb25zXSIKICAgIGVjaG8gIiIKICAgIGVjaG8gIk9wdGlvbnM6IgogICAgZWNobyAiICAgLWIgICAgICAgICBiYXNlIGRpcmVjdG9yeSBmb3IgbW91bnQgcG9pbnRzIChkZWZhdWx0OiAvZGF0YWRpc2tzKSIKICAgIGVjaG8gIiAgIC1oICAgICAgICAgdGhpcyBoZWxwIG1lc3NhZ2UiCiAgICBlY2hvICIgICAtcyAgICAgICAgIGNyZWF0ZSBhIHN0cmlwZWQgUkFJRCBhcnJheSAobm8gcmVkdW5kYW5jeSkiCiAgICBlY2hvICIgICAtbyAgICAgICAgIG1vdW50IG9wdGlvbnMgZm9yIGRhdGEgZGlzayIKfQoKbG9nKCkKewoKICAgIGVjaG8gIiQxIgp9CgppZiBbICIke1VJRH0iIC1uZSAwIF07CnRoZW4KICAgIGxvZyAiU2NyaXB0IGV4ZWN1dGVkIHdpdGhvdXQgcm9vdCBwZXJtaXNzaW9ucyIKICAgIGVjaG8gIllvdSBtdXN0IGJlIHJvb3QgdG8gcnVuIHRoaXMgcHJvZ3JhbS4iID4mMgogICAgZXhpdCAzCmZpCgojIEJhc2UgcGF0aCBmb3IgZGF0YSBkaXNrIG1vdW50IHBvaW50cwpEQVRBX0JBU0U9Ii9kYXRhZGlza3MiCiMgTW91bnQgb3B0aW9ucyBmb3IgZGF0YSBkaXNrCk1PVU5UX09QVElPTlM9Im5vYXRpbWUsbm9kaXJhdGltZSxub2Rldixub2V4ZWMsbm9zdWlkLG5vZmFpbCIKIyBEZXRlcm1pbmVzIHdoZXRlciBwYXJ0aXRpb24gYW5kIGZvcm1hdCBkYXRhIGRpc2tzIGFzIHJhaWQgc2V0IG9yIG5vdApSQUlEX0NPTkZJR1VSQVRJT049MAoKd2hpbGUgZ2V0b3B0cyBiOnNobzogb3B0bmFtZTsgZG8KICAgIGxvZyAiT3B0aW9uICRvcHRuYW1lIHNldCB3aXRoIHZhbHVlICR7T1BUQVJHfSIKICBjYXNlICR7b3B0bmFtZX0gaW4KICAgIGIpICAjc2V0IGNsc3V0ZXIgbmFtZQogICAgICBEQVRBX0JBU0U9JHtPUFRBUkd9CiAgICAgIDs7CiAgICBzKSAjUGFydGl0aW9uIGFuZCBmb3JtYXQgZGF0YSBkaXNrcyBhcyByYWlkIHNldAogICAgICBSQUlEX0NPTkZJR1VSQVRJT049MQogICAgICA7OwogICAgbykgI21vdW50IG9wdGlvbgogICAgICBNT1VOVF9PUFRJT05TPSR7T1BUQVJHfQogICAgICA7OwogICAgaCkgICNzaG93IGhlbHAKICAgICAgaGVscAogICAgICBleGl0IDIKICAgICAgOzsKICAgIFw/KSAjdW5yZWNvZ25pemVkIG9wdGlvbiAtIHNob3cgaGVscAogICAgICBlY2hvIC1lIFxcbiJPcHRpb24gLSR7Qk9MRH0kT1BUQVJHJHtOT1JNfSBub3QgYWxsb3dlZC4iCiAgICAgIGhlbHAKICAgICAgZXhpdCAyCiAgICAgIDs7CiAgZXNhYwpkb25lCgpnZXRfbmV4dF9tZF9kZXZpY2UoKSB7CiAgICBzaG9wdCAtcyBleHRnbG9iCiAgICBMQVNUX0RFVklDRT0kKGxzIC0xIC9kZXYvbWQrKFswLTldKSAyPi9kZXYvbnVsbHxzb3J0IC1ufHRhaWwgLW4xKQogICAgaWYgWyAteiAiJHtMQVNUX0RFVklDRX0iIF07IHRoZW4KICAgICAgICBORVhUPS9kZXYvbWQwCiAgICBlbHNlCiAgICAgICAgTlVNQkVSPSQoKCR7TEFTVF9ERVZJQ0UvXC9kZXZcL21kL30pKQogICAgICAgIE5FWFQ9L2Rldi9tZCR7TlVNQkVSfQogICAgZmkKICAgIGVjaG8gJHtORVhUfQp9Cgppc19wYXJ0aXRpb25lZCgpIHsKICAgIE9VVFBVVD0kKHBhcnR4IC1zICR7MX0gMj4mMSkKICAgIGVncmVwICJwYXJ0aXRpb24gdGFibGUgZG9lcyBub3QgY29udGFpbnMgdXNhYmxlIHBhcnRpdGlvbnN8ZmFpbGVkIHRvIHJlYWQgcGFydGl0aW9uIHRhYmxlIiA8PDwgIiR7T1VUUFVUfSIgPi9kZXYvbnVsbCAyPiYxCiAgICBpZiBbICR7P30gLWVxIDAgXTsgdGhlbgogICAgICAgIHJldHVybiAxCiAgICBlbHNlCiAgICAgICAgcmV0dXJuIDAKICAgIGZpCn0KCmhhc19maWxlc3lzdGVtKCkgewogICAgREVWSUNFPSR7MX0KICAgIE9VVFBVVD0kKGZpbGUgLUwgLXMgJHtERVZJQ0V9KQogICAgZ3JlcCBmaWxlc3lzdGVtIDw8PCAiJHtPVVRQVVR9IiA+IC9kZXYvbnVsbCAyPiYxCiAgICByZXR1cm4gJHs/fQp9CgpzY2FuX2Zvcl9uZXdfZGlza3MoKSB7CiAgICAjIExvb2tzIGZvciB1bnBhcnRpdGlvbmVkIGRpc2tzCiAgICBkZWNsYXJlIC1hIFJFVAogICAgREVWUz0oJChscyAtMSAvZGV2L3NkKnxlZ3JlcCAtdiAiWzAtOV0kIikpCiAgICBmb3IgREVWIGluICIke0RFVlNbQF19IjsKICAgIGRvCiAgICAgICAgIyBUaGUgZGlzayB3aWxsIGJlIGNvbnNpZGVyZWQgYSBjYW5kaWRhdGUgZm9yIHBhcnRpdGlvbmluZwogICAgICAgICMgYW5kIGZvcm1hdHRpbmcgaWYgaXQgZG9lcyBub3QgaGF2ZSBhIHNkPzEgZW50cnkgb3IKICAgICAgICAjIGlmIGl0IGRvZXMgaGF2ZSBhbiBzZD8xIGVudHJ5IGFuZCBkb2VzIG5vdCBjb250YWluIGEgZmlsZXN5c3RlbQogICAgICAgIGlzX3BhcnRpdGlvbmVkICIke0RFVn0iCiAgICAgICAgaWYgWyAkez99IC1lcSAwIF07CiAgICAgICAgdGhlbgogICAgICAgICAgICBoYXNfZmlsZXN5c3RlbSAiJHtERVZ9MSIKICAgICAgICAgICAgaWYgWyAkez99IC1uZSAwIF07CiAgICAgICAgICAgIHRoZW4KICAgICAgICAgICAgICAgIFJFVCs9IiAke0RFVn0iCiAgICAgICAgICAgIGZpCiAgICAgICAgZWxzZQogICAgICAgICAgICBSRVQrPSIgJHtERVZ9IgogICAgICAgIGZpCiAgICBkb25lCiAgICBlY2hvICIke1JFVH0iCn0KCmdldF9uZXh0X21vdW50cG9pbnQoKSB7CiAgICBESVJTPSQobHMgLTFkICR7REFUQV9CQVNFfS9kaXNrKiAyPi9kZXYvbnVsbHwgc29ydCAtLXZlcnNpb24tc29ydCkKICAgIE1BWD0kKGVjaG8gIiR7RElSU30ifHRhaWwgLW4gMSB8IHRyIC1kICJbYS16QS1aL10iKQogICAgaWYgWyAteiAiJHtNQVh9IiBdOwogICAgdGhlbgogICAgICAgIGVjaG8gIiR7REFUQV9CQVNFfS9kaXNrMSIKICAgICAgICByZXR1cm4KICAgIGZpCiAgICBJRFg9MQogICAgd2hpbGUgWyAiJHtJRFh9IiAtbHQgIiR7TUFYfSIgXTsKICAgIGRvCiAgICAgICAgTkVYVF9ESVI9IiR7REFUQV9CQVNFfS9kaXNrJHtJRFh9IgogICAgICAgIGlmIFsgISAtZCAiJHtORVhUX0RJUn0iIF07CiAgICAgICAgdGhlbgogICAgICAgICAgICBlY2hvICIke05FWFRfRElSfSIKICAgICAgICAgICAgcmV0dXJuCiAgICAgICAgZmkKICAgICAgICBJRFg9JCgoICR7SURYfSArIDEgKSkKICAgIGRvbmUKICAgIElEWD0kKCggJHtNQVh9ICsgMSkpCiAgICBlY2hvICIke0RBVEFfQkFTRX0vZGlzayR7SURYfSIKfQoKYWRkX3RvX2ZzdGFiKCkgewogICAgVVVJRD0kezF9CiAgICBNT1VOVFBPSU5UPSR7Mn0KICAgIGdyZXAgIiR7VVVJRH0iIC9ldGMvZnN0YWIgPi9kZXYvbnVsbCAyPiYxCiAgICBpZiBbICR7P30gLWVxIDAgXTsKICAgIHRoZW4KICAgICAgICBlY2hvICJOb3QgYWRkaW5nICR7VVVJRH0gdG8gZnN0YWIgYWdhaW4gKGl0J3MgYWxyZWFkeSB0aGVyZSEpIgogICAgZWxzZQogICAgICAgIExJTkU9IlVVSUQ9XCIke1VVSUR9XCJcdCR7TU9VTlRQT0lOVH1cdGV4dDRcdCR7TU9VTlRfT1BUSU9OU31cdDEgMiIKICAgICAgICBlY2hvIC1lICIke0xJTkV9IiA+PiAvZXRjL2ZzdGFiCiAgICBmaQp9Cgpkb19wYXJ0aXRpb24oKSB7CiMgVGhpcyBmdW5jdGlvbiBjcmVhdGVzIG9uZSAoMSkgcHJpbWFyeSBwYXJ0aXRpb24gb24gdGhlCiMgZGlzaywgdXNpbmcgYWxsIGF2YWlsYWJsZSBzcGFjZQogICAgX2Rpc2s9JHsxfQogICAgX3R5cGU9JHsyfQogICAgaWYgWyAteiAiJHtfdHlwZX0iIF07IHRoZW4KICAgICAgICAjIGRlZmF1bHQgdG8gTGludXggcGFydGl0aW9uIHR5cGUgKGllLCBleHQzL2V4dDQveGZzKQogICAgICAgIF90eXBlPTgzCiAgICBmaQogICAgZWNobyAibgpwCjEKCgp0CiR7X3R5cGV9CncifCBmZGlzayAiJHtfZGlza30iCgojCiMgVXNlIHRoZSBiYXNoLXNwZWNpZmljICRQSVBFU1RBVFVTIHRvIGVuc3VyZSB3ZSBnZXQgdGhlIGNvcnJlY3QgZXhpdCBjb2RlCiMgZnJvbSBmZGlzayBhbmQgbm90IGZyb20gZWNobwppZiBbICR7UElQRVNUQVRVU1sxXX0gLW5lIDAgXTsKdGhlbgogICAgZWNobyAiQW4gZXJyb3Igb2NjdXJyZWQgcGFydGl0aW9uaW5nICR7X2Rpc2t9IiA+JjIKICAgIGVjaG8gIkkgY2Fubm90IGNvbnRpbnVlIiA+JjIKICAgIGV4aXQgMgpmaQp9CiNlbmQgZG9fcGFydGl0aW9uCgpzY2FuX3BhcnRpdGlvbl9mb3JtYXQoKQp7CiAgICBsb2cgIkJlZ2luIHNjYW5uaW5nIGFuZCBmb3JtYXR0aW5nIGRhdGEgZGlza3MiCgogICAgRElTS1M9KCQoc2Nhbl9mb3JfbmV3X2Rpc2tzKSkKCglpZiBbICIkeyNESVNLU30iIC1lcSAwIF07Cgl0aGVuCgkgICAgbG9nICJObyB1bnBhcnRpdGlvbmVkIGRpc2tzIHdpdGhvdXQgZmlsZXN5c3RlbXMgZGV0ZWN0ZWQiCgkgICAgcmV0dXJuCglmaQoJZWNobyAiRGlza3MgYXJlICR7RElTS1NbQF19IgoJZm9yIERJU0sgaW4gIiR7RElTS1NbQF19IjsKCWRvCgkgICAgZWNobyAiV29ya2luZyBvbiAke0RJU0t9IgoJICAgIGlzX3BhcnRpdGlvbmVkICR7RElTS30KCSAgICBpZiBbICR7P30gLW5lIDAgXTsKCSAgICB0aGVuCgkgICAgICAgIGVjaG8gIiR7RElTS30gaXMgbm90IHBhcnRpdGlvbmVkLCBwYXJ0aXRpb25pbmciCgkgICAgICAgIGRvX3BhcnRpdGlvbiAke0RJU0t9CgkgICAgZmkKCSAgICBQQVJUSVRJT049JChmZGlzayAtbCAke0RJU0t9fGdyZXAgLUEgMSBEZXZpY2V8dGFpbCAtbiAxfGF3ayAne3ByaW50ICQxfScpCgkgICAgaGFzX2ZpbGVzeXN0ZW0gJHtQQVJUSVRJT059CgkgICAgaWYgWyAkez99IC1uZSAwIF07CgkgICAgdGhlbgoJICAgICAgICBlY2hvICJDcmVhdGluZyBmaWxlc3lzdGVtIG9uICR7UEFSVElUSU9OfS4iCgkjICAgICAgICBlY2hvICJQcmVzcyBDdHJsLUMgaWYgeW91IGRvbid0IHdhbnQgdG8gZGVzdHJveSBhbGwgZGF0YSBvbiAke1BBUlRJVElPTn0iCgkjICAgICAgICBzbGVlcCAxMAoJICAgICAgICBta2ZzIC1qIC10IGV4dDQgJHtQQVJUSVRJT059CgkgICAgZmkKCSAgICBNT1VOVFBPSU5UPSQoZ2V0X25leHRfbW91bnRwb2ludCkKCSAgICBlY2hvICJOZXh0IG1vdW50IHBvaW50IGFwcGVhcnMgdG8gYmUgJHtNT1VOVFBPSU5UfSIKCSAgICBbIC1kICIke01PVU5UUE9JTlR9IiBdIHx8IG1rZGlyIC1wICIke01PVU5UUE9JTlR9IgoJICAgIHJlYWQgVVVJRCBGU19UWVBFIDwgPChibGtpZCAtdSBmaWxlc3lzdGVtICR7UEFSVElUSU9OfXxhd2sgLUYgIls9IF0iICd7cHJpbnQgJDMiICIkNX0nfHRyIC1kICJcIiIpCgkgICAgYWRkX3RvX2ZzdGFiICIke1VVSUR9IiAiJHtNT1VOVFBPSU5UfSIKCSAgICBlY2hvICJNb3VudGluZyBkaXNrICR7UEFSVElUSU9OfSBvbiAke01PVU5UUE9JTlR9IgoJICAgIG1vdW50ICIke01PVU5UUE9JTlR9IgoJZG9uZQp9CgpjcmVhdGVfc3RyaXBlZF92b2x1bWUoKQp7CiAgICBESVNLUz0oJHtAfSkKCglpZiBbICIkeyNESVNLU1tAXX0iIC1lcSAwIF07Cgl0aGVuCgkgICAgbG9nICJObyB1bnBhcnRpdGlvbmVkIGRpc2tzIHdpdGhvdXQgZmlsZXN5c3RlbXMgZGV0ZWN0ZWQiCgkgICAgcmV0dXJuCglmaQoKCWVjaG8gIkRpc2tzIGFyZSAke0RJU0tTW0BdfSIKCglkZWNsYXJlIC1hIFBBUlRJVElPTlMKCglmb3IgRElTSyBpbiAiJHtESVNLU1tAXX0iOwoJZG8KCSAgICBlY2hvICJXb3JraW5nIG9uICR7RElTS30iCgkgICAgaXNfcGFydGl0aW9uZWQgJHtESVNLfQoJICAgIGlmIFsgJHs/fSAtbmUgMCBdOwoJICAgIHRoZW4KCSAgICAgICAgZWNobyAiJHtESVNLfSBpcyBub3QgcGFydGl0aW9uZWQsIHBhcnRpdGlvbmluZyIKCSAgICAgICAgZG9fcGFydGl0aW9uICR7RElTS30gZmQKCSAgICBmaQoKCSAgICBQQVJUSVRJT049JChmZGlzayAtbCAke0RJU0t9fGdyZXAgLUEgMiBEZXZpY2V8dGFpbCAtbiAxfGF3ayAne3ByaW50ICQxfScpCgkgICAgUEFSVElUSU9OUys9KCIke1BBUlRJVElPTn0iKQoJZG9uZQoKICAgIE1EREVWSUNFPSQoZ2V0X25leHRfbWRfZGV2aWNlKQoJdWRldmFkbSBjb250cm9sIC0tc3RvcC1leGVjLXF1ZXVlCgltZGFkbSAtLWNyZWF0ZSAke01EREVWSUNFfSAtLWxldmVsIDAgLWMgNjQgLS1yYWlkLWRldmljZXMgJHsjUEFSVElUSU9OU1tAXX0gJHtQQVJUSVRJT05TWypdfQoJdWRldmFkbSBjb250cm9sIC0tc3RhcnQtZXhlYy1xdWV1ZQoKCU1PVU5UUE9JTlQ9JChnZXRfbmV4dF9tb3VudHBvaW50KQoJZWNobyAiTmV4dCBtb3VudCBwb2ludCBhcHBlYXJzIHRvIGJlICR7TU9VTlRQT0lOVH0iCglbIC1kICIke01PVU5UUE9JTlR9IiBdIHx8IG1rZGlyIC1wICIke01PVU5UUE9JTlR9IgoKCSNNYWtlIGEgZmlsZSBzeXN0ZW0gb24gdGhlIG5ldyBkZXZpY2UKCVNUUklERT0xMjggIyg1MTJrQiBzdHJpcGUgc2l6ZSkgLyAoNGtCIGJsb2NrIHNpemUpCglQQVJUSVRJT05TTlVNPSR7I1BBUlRJVElPTlNbQF19CglTVFJJUEVXSURUSD0kKCgke1NUUklERX0gKiAke1BBUlRJVElPTlNOVU19KSkKCglta2ZzLmV4dDQgLWIgNDA5NiAtRSBzdHJpZGU9JHtTVFJJREV9LHN0cmlwZS13aWR0aD0ke1NUUklQRVdJRFRIfSxub2Rpc2NhcmQgIiR7TURERVZJQ0V9IgoKCXJlYWQgVVVJRCBGU19UWVBFIDwgPChibGtpZCAtdSBmaWxlc3lzdGVtICR7TURERVZJQ0V9fGF3ayAtRiAiWz0gXSIgJ3twcmludCAkMyIgIiQ1fSd8dHIgLWQgIlwiIikKCglhZGRfdG9fZnN0YWIgIiR7VVVJRH0iICIke01PVU5UUE9JTlR9IgoKCW1vdW50ICIke01PVU5UUE9JTlR9Igp9CgpjaGVja19tZGFkbSgpIHsKICAgIGRwa2cgLXMgbWRhZG0gPi9kZXYvbnVsbCAyPiYxCiAgICBpZiBbICR7P30gLW5lIDAgXTsgdGhlbgogICAgICAgIChhcHQtZ2V0IC15IHVwZGF0ZSB8fCAoc2xlZXAgMTU7IGFwdC1nZXQgLXkgdXBkYXRlKSkgPiAvZGV2L251bGwKICAgICAgICBERUJJQU5fRlJPTlRFTkQ9bm9uaW50ZXJhY3RpdmUgYXB0LWdldCAteSBpbnN0YWxsIG1kYWRtIC0tZml4LW1pc3NpbmcKICAgIGZpCn0KCiMgQ3JlYXRlIFBhcnRpdGlvbnMKRElTS1M9JChzY2FuX2Zvcl9uZXdfZGlza3MpCgppZiBbICIkUkFJRF9DT05GSUdVUkFUSU9OIiAtZXEgMSBdOyB0aGVuCiAgICBjaGVja19tZGFkbQogICAgY3JlYXRlX3N0cmlwZWRfdm9sdW1lICIke0RJU0tTW0BdfSIKZWxzZQogICAgc2Nhbl9wYXJ0aXRpb25fZm9ybWF0CmZpCg=="
  }
  PROTECTED_SETTINGS

  depends_on = [
    azurerm_virtual_machine_data_disk_attachment.atch
  ]
}
