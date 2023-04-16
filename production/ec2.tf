module "ec2_cluster" {
  source                 = "../modules/terraform-aws-ec2-instance"

  name                   = "pcarey-cluster"
  instance_count         = 1

  ami                    = "ami-05064bb33b40c33a2"
  instance_type          = "t2.small"
  key_name               = "pcarey-one"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

}

