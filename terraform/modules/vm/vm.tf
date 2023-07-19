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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4p4gO+lRNbNmvJ0rj7XZNeVI7FWrfCVqi/oHU7drpoPf4HfRgaSen6+VXsOoVEX+bhUiyp/9NEljp/N+phtvDbohEkIN1UPCUkci47bMIu0ejOrI3pUqi+1uN+lUeiSyBtPqjXNm/BRCHPh2lI+hYx4Xb8iCDd6y4Iw4tunhPMKlaQluVeqqhKPTsw/Dzj+X3CQ54u9b0TmzrMqa1yyfPQfYWDjwz5K1LAWilhhE+HgmTLNLeGL1tKyazmQXPzlD2Z4Thp1nC6UdKviKDE4P0vwvG51BTtdFzN0waM1XOxhWwDCx0ciYkTVGWMftqqjXbPXXtS8QAWY82beNWnOK9zlRIkDEXKSj61EFAkd5v0kKm99gbT1vXMrdnV8AxIS+sHbGekYJjzZc43W+OZiWBS6bLJDFFBtnH+L65CKLcDyPWM2Zo391F9sDEXum4TJWDqZEgfEfCCQoXs5yYKXUnPRrdZnKtDDdEW32keD9Zpm0GXMfYzeK4nS2foA+blCM= devopsagent@khuongLinuxVM"
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
