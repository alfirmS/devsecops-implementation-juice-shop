variable "cluster_name" {
  description = "Name of the K3D cluster"
  type        = string
  default     = "dev-cluster"

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.cluster_name))
    error_message = "Cluster name must contain only alphanumeric characters or dashes."
  }
}

variable "kubeconfig_output_file" {
  description = "Path untuk menyimpan file kubeconfig"
  type        = string
  default     = "kubeconfig-dev-cluster.yaml"

  validation {
    condition     = !startswith(var.kubeconfig_output_file, "/") && can(regex("^[a-zA-Z0-9._/-]+\\.(yaml|yml)$", var.kubeconfig_output_file))
    error_message = "kubeconfig_output_file harus berupa path relatif yang valid dan diakhiri dengan .yaml atau .yml"
  }
}
