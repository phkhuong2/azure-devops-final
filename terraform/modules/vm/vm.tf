resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}-ni"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}-vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "${var.admin_username}"
  admin_password      = "${var.admin_password}"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.test.id]
  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHGwH5jj478LJ7aZKeno+FfPEx7hJh6UOxVOxBFAcaMKvMeEF6LHEXAj8PRGnu8FFqdMkxGyGLt//GwTgSWw9mub2Fp3IAdYGPTmBzfNWDkSdJmc4jmPrbch+Fqh8bEe+biUcQ5g2QRUCKWLXsHbR4hwg9B8+gPFR4I4wh6kOKnQW+/ZCe1pB2j09dxr2WELzSflE+f7ErAnuhVzYtfQWlrFTiLEcxjVsqf2+Ra0QUgOGJPXM3aeNywClSdMGExQKhaQLWWPT6hyUbIXOwHuY+8KtU1bp9b832m/KoHkgx7K7DugPAh8VsZaFe+I3csYHE2ZuopuWwQrIXOrs7yNeiX5Ij9u7GqOK9ut6sU+YAQeqXuLfv6F0VM0Wji2eOGA5SNt0iUywn0FxL58Zu9noubA1mpp3/rCe4GH0K0Pim93cRi8CkrqldK9qdrDNcZqlHKvZcUGc4QF4mAdx+6nuCMPLErSImVnlIkCXwLopQ2m5PQmxJREAICsqmy+Pdwh8= devopsagent@khuongLinuxVM"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
