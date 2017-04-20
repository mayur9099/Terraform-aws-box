output "app.0.ip" {
  value = "${aws_instance.app.0.private_ip}"
}

output "slave.0.ip" {
  value = "${aws_instance.slave.0.public_ip}"
}

output "slave.1.ip" {
  value = "${aws_instance.slave.1.public_ip}"
}

output "app.1.ip" {
  value = "${aws_instance.app.1.private_ip}"
}

output "nat.ip" {
  value = "${aws_instance.nat.public_ip}"
}

output "elb.hostname" {
  value = "${aws_elb.app.dns_name}"
}

output "bastion-host.0.ip" {
  value = "${aws_instance.bastion-host.0.public_ip}"
}

output "jenkins.0.ip" {
  value = "${aws_instance.jenkins.0.public_ip}"
}

output "spinnaker.0.ip" {
  value = "${aws_instance.spinnaker.0.public_ip}"
}
