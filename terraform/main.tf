# Membuat cluster jika belum ada
resource "null_resource" "k3d_cluster" {
  provisioner "local-exec" {
    command = <<EOT
      set -euo pipefail

      if k3d cluster list | grep -qw "${var.cluster_name}"; then
        echo "✅ Cluster '${var.cluster_name}' sudah ada. Lewati pembuatan."
      else
        echo "🚀 Membuat cluster '${var.cluster_name}'..."
        k3d cluster create ${var.cluster_name} --no-lb --k3s-arg "--disable=traefik@server:0"
      fi
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

  triggers = {
    always_run = timestamp()
  }
}

# Tulis kubeconfig ke file
resource "null_resource" "write_kubeconfig" {
  provisioner "local-exec" {
    command = <<EOT
      echo "📝 Menulis kubeconfig ke ${var.kubeconfig_output_file}..."
      cat $(k3d kubeconfig write ${var.cluster_name}) > ${var.kubeconfig_output_file}
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [null_resource.k3d_cluster]

  triggers = {
    always_run = timestamp()
  }
}
