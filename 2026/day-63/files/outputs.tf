output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_id" {
  value = aws_subnet.my_subnet.id
}

output "instanace_id" {

    value = aws_instance.my_instance.id

}

output "instanace_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "instanace_public_dns" {
  value = aws_instance.my_instance.public_dns
}

output "security_group_id" {
  value = aws_security_group.my_security_group.id
}