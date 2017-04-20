resource "aws_key_pair" "deployer" {
  key_name = "AIC-deployer-key"
  public_key = "${file("/Users/mnarang/.ssh/id_rsa.pub")}"
}
