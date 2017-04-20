/* Default security group */
resource "aws_security_group" "default" {
  name = "AIC-example"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  tags { 
    Name = "AIC-default-vpc" 
  }
}

/* Security group for the nat server */
resource "aws_security_group" "nat" {
  name = "AIC-TEST-example"
  description = "Security group for nat instances that allows SSH and VPN traffic from internet. Also allows outbound HTTP[S]"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 1194
    to_port   = 1194
    protocol  = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags { 
    Name = "AIC-TEST-example" 
  }
}

/* Security group for the web */
resource "aws_security_group" "web" {
  name = "web-AIC-TEST-example"
  description = "Security group for web that allows web traffic from internet"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { 
    Name = "web-AIC-TEST-example" 
  }
}

resource "aws_security_group" "adm_bastion" {
  vpc_id = "${aws_vpc.default.id}"
  name="ADM_BASTION"
  description="Bastion Host SG"
  tags {
    Name="ADM_BASTION"
  }
}

resource "aws_security_group" "infra_spinnaker" {
  vpc_id = "${aws_vpc.default.id}"
  name="INFRA_SPINNAKER"
  description="Spinnaker Security group for ${aws_vpc.default.id}"
  tags {
    Name="INFRA_SPINNAKER"
    application="none"
    allocated="false"
    allocated_on="none"
    owner="none"
  }
}

/* Jenkins SG */
resource "aws_security_group" "infra_jenkins" {
  vpc_id = "${aws_vpc.default.id}"
  name="INFRA_JENKINS"
  description="Jenkins Security group for ${aws_vpc.default.id}"
  tags {
    Name="INFRA_JENKINS"
    application="none"
    allocated="false"
    allocated_on="none"
    owner="none"
  }
  ingress {
    from_port="8000"
    to_port="8000"
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }
  ingress {
    from_port="80"
    to_port="80"
    protocol="tcp"
    security_groups=["${aws_security_group.infra_spinnaker.id}"]
  }
}
