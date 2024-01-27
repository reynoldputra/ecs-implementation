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

output "private_subnet_id" {
  value = aws_subnet.private_a.id
}

output "public_subnet_id" {
  value = aws_subnet.public_a.id
}
