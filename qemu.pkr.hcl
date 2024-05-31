packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "archlinux" {
  iso_url      = "Arch-Linux-x86_64-cloudimg.qcow2"
  iso_checksum = "none"
  disk_image   = true

  ssh_username   = "root"
  ssh_agent_auth = true

  # https://cloudinit.readthedocs.io/en/latest/tutorial/qemu.html
  # https://developer.hashicorp.com/packer/integrations/hashicorp/qemu
  shutdown_command = "cloud-init status --wait && shutdown -P now"

  cd_files = [
    "archlinux/user-data",
    "archlinux/meta-data",
    "archlinux/vendor-data"
  ]

  cd_label = "cidata"
}

build {
  sources = ["qemu.archlinux"]
}
