output "sg_egress_all_id" {
  value = aws_security_group.egress_all.id
}

output "sg_ingress_api_id" {
  value = aws_security_group.ingress_api.id
}

output "sg_ingress_http" {
  value = aws_security_group.http.id
}

output "sg_ingress_https" {
  value = aws_security_group.https.id
}

output "private_a_subnet_id" {
  value = aws_subnet.private_a.id
}

output "private_b_subnet_id" {
  value = aws_subnet.private_b.id
}

output "public_a_subnet_id" {
  value = aws_subnet.public_a.id
}

output "public_b_subnet_id" {
  value = aws_subnet.public_b.id
}

output "nat_eip_id" {
  value = aws_eip.nat_eip.id
}

output "private_ngw_id" {
  value = aws_nat_gateway.ngw.id
}

output "vpc_id" {
  value = aws_vpc.app_vpc.id
}

output "igw" {
  value = aws_internet_gateway.igw
}
