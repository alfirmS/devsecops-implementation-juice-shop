output "kubeconfig_path" {
  description = "Path absolut ke kubeconfig file"
  value       = "${path.cwd}/${var.kubeconfig_output_file}"
}

output "kubeconfig_export_command" {
  description = "Perintah untuk mengekspor KUBECONFIG"
  value       = "export KUBECONFIG=${path.cwd}/${var.kubeconfig_output_file}"
}

