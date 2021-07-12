
resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "../modules/terraform-aws-key-pair"

  key_name   = "pcarey-one"
  public_key = tls_private_key.this.public_key_openssh
}
