# Generar clave SSH dentro de Terraform
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Guardar la clave privada en un archivo local
resource "local_file" "private_key" {
  filename = "ssh/rsa"
  content  = tls_private_key.ssh_key.private_key_pem
  file_permission = "0600"
}
