resource "local_file" "kc" {
  content         = local.kubeconfig
  filename        = var.kubeconfig_output_path != "" ? var.kubeconfig_output_path : "${path.cwd}/eks-kubeconfig"
  file_permission = "0600"
}
