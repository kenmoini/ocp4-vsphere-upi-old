#############################################################################
## Generate new cluster SSH Keys
resource "tls_private_key" "cluster_new_key" {
  algorithm = "RSA"
}
resource "local_file" "cluster_new_priv_file" {
  content         = tls_private_key.cluster_new_key.private_key_pem
  filename        = "${var.generationDir}/.${var.cluster_name}.${var.domain}/priv.pem"
  file_permission = "0600"
}
resource "local_file" "cluster_new_pub_file" {
  content  = tls_private_key.cluster_new_key.public_key_openssh
  filename = "${var.generationDir}/.${var.cluster_name}.${var.domain}/pub.key"
}

#############################################################################
## Setup Folder, Tag Category, and Tag(s)
resource "vsphere_tag_category" "category" {
  name        = "ocp4-${var.cluster_name}"
  description = "Added by ocp4-vsphere-upi do not remove"
  cardinality = "SINGLE"

  associable_types = [
    "VirtualMachine",
    "ResourcePool",
    "Folder",
    "com.vmware.content.Library",
    "com.vmware.content.library.item"
  ]
}
resource "vsphere_tag" "tag" {
  name        = var.cluster_name
  category_id = vsphere_tag_category.category.id
  description = "Added by ocp4-vsphere-upi do not remove"
}
resource "vsphere_folder" "vm_folder" {
  path          = "ocp4-${var.cluster_name}-vms"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
  tags          = [vsphere_tag.tag.id]
}

## [OPTIONAL] Create new content Library - used if manually creating new VMs from the OVA, primarily in testing
##resource "vsphere_content_library" "library" {
##  name            = "ocp4Deployer"
##  storage_backing = [data.vsphere_datastore.datastore.id]
##  description     = "Primarily Red Hat CoreOS images to deploy OpenShift"
##}
#### Upload FCOS OVA to the new content library
##resource "vsphere_content_library_item" "rhcos" {
##  name        = "RHCOS ${var.ocp_version}"
##  description = "Red Hat CoreOS ${var.ocp_version} template"
##  library_id  = vsphere_content_library.library.id
##  file_url    = "${var.generationDir}/cache/rhcos-${var.ocp_version}-vmware.x86_64.ova"
##}

#############################################################################
## Create install-config from template
## Create manifests
## Create ignition configs
## Create template VM from OVA

