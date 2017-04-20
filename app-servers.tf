/* App servers */
resource "aws_instance" "app" {
  count = 2
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.private.id}"
  security_groups = ["${aws_security_group.default.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false
  tags = { 
    Name = "AIC-test-example-app-${count.index}"
  }
}

resource "aws_instance" "slave" {
  count = 2
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false
  tags = {
    Name = "Slave-test-example-app-${count.index}"
  }
}

/* bastion instance */
resource "aws_instance" "bastion-host" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false
  tags = {
    Name = "Bastion-Host-example-app-${count.index}"
  }
}

/* jenkins instance */
resource "aws_instance" "jenkins" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"  
  iam_instance_profile = "${aws_iam_instance_profile.jenkins_instance_profile.id}"
  source_dest_check = false
  tags = {
    Name = "Jenkins-Host-example-app-${count.index}"
  }
}

/* spinnaker instance */
resource "aws_instance" "spinnaker" {
  ami = "${lookup(var.aws_spinnaker_amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.spinnaker_instance_profile.id}"  
  source_dest_check = false
  tags = {
    Name = "Spinnaker-Host-example-app-${count.index}"
  }
}

/* Load balancer */
resource "aws_elb" "app" {
  name = "AIC-test-example-elb"
  subnets = ["${aws_subnet.public.id}"]
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.web.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  instances = ["${aws_instance.app.*.id}"]
}
