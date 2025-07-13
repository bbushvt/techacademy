output "ibm_cloud_zone1_gateway_ip_a" {
  description = "The public IP address for the first gateway in zone 1"
  value = ibm_is_vpn_gateway.ibm_aws_vpn_gw_zone_1.members[0].address
}

output "ibm_cloud_zone1_gateway_ip_b" {
  description = "The public IP address for the second gateway in zone 1"
  value = ibm_is_vpn_gateway.ibm_aws_vpn_gw_zone_1.members[1].address
}

#output of Tunnel 1 IP address
output "aws_ibm_zone1_gateway_ip_1_a" {
  value = aws_vpn_connection.ibm_cloud_zone1_a.tunnel1_address
}

#output of Tunnel 2 IP address
output "aws_ibm_zone1_gateway_ip_1_b" {
  value = aws_vpn_connection.ibm_cloud_zone1_a.tunnel2_address
}

# #output of Tunnel 1 IP address
# output "aws_ibm_zone1_gateway_ip_2_a" {
#   value = aws_vpn_connection.ibm_cloud_zone1_b.tunnel1_address
# }

# #output of Tunnel 2 IP address
# output "aws_ibm_zone1_gateway_ip_2_b" {
#   value = aws_vpn_connection.ibm_cloud_zone1_b.tunnel2_address
# }