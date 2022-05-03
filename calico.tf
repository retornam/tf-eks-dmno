resource "null_resource" "calico" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash"]
    working_dir = "${path.module}/scripts/"
    command     = "calico.sh"
    environment = {
      KUBECONFIG     = "${local_file.kc.filename}"
      CALICO_VERSION = "${var.tigeraoperator_version}"
    }
  }
}
