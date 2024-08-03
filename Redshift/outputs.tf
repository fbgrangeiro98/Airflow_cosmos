# Define uma saída para o endpoint do Redshift
output "redshift_endpoint" {
  value = aws_redshiftserverless_workgroup.example.endpoint # Retorna o endpoint do grupo de trabalho do Redshift
}