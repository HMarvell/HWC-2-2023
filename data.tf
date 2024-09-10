data "template_cloudinit_config" "logstash_script" {

  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}./scripts/lsinstall.sh",
      {}
    )
  }
}
