output "cluster_name" {
  value = aws_eks_cluster.team2_cluster_2.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.team2_cluster_2.endpoint
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.team2_cluster_2.certificate_authority[0].data
}

output "node_group_role_arn" {
  value = aws_iam_role.team2_node_role_2.arn
}

output "eks_node_group_name" {
  value = aws_eks_node_group.team2_node_group_2.node_group_name
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.team2_cluster_2.arn
}


output "vpc_id" {
  value = aws_vpc.team2_vpc_2.id
}

output "public_subnet_a_id" {
  value = aws_subnet.team2_public_subnet_2.id
}

output "private_subnet_a_id" {
  value = aws_subnet.team2_private_subnet_2.id
}

# output "private_subnet_a_id" {
#   value = aws_subnet.private_subnet_a.id
# }

# output "private_subnet_b_id" {
#   value = aws_subnet.private_subnet_b.id
# }

output "nat_gateway_id" {
  value = aws_nat_gateway.team2_nat_gateway_2.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.team2_igw_2.id
}

# output "namespace_name" {
#   value = kubernetes_namespace.namespace.metadata[0].name
# }

# output "persistent_volume_claim_name" {
#   value = kubernetes_persistent_volume_claim.library_app_pvc.metadata[0].name
# }

# output "deployment_name" {
#   value = kubernetes_deployment.library_app.metadata[0].name
# }

# output "service_name" {
#   value = kubernetes_service.library_app_service.metadata[0].name
# }