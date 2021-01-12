variable "generationDir" {
  type    = string
  default = "~/.generated"
}

#############################################################################
## VMWare Infrastructure Target Configuration

variable "vmware_datacenter" {
  type    = string
  default = "VMWDC"
}
variable "vmware_datastore" {
  type    = string
  default = "bigNVMe"
}
variable "vmware_cluster" {
  type    = string
  default = "CoreCluster"
}
variable "vmware_network" {
  type    = string
  default = "VM Network"
}
variable "vmware_ova_host" {
  type    = string
  default = "192.168.42.30"
}

#############################################################################
## Cluster Details

variable "cluster_name" {
  type    = string
  default = "ocp4"
}
variable "domain" {
  type    = string
  default = "vmware.labs"
}

#############################################################################
## Cluster VM Counts

variable "ocp4_orchestrator_node_count" {
  type    = string
  default = "3"
}
variable "ocp4_infra_node_count" {
  type    = string
  default = "3"
}
variable "ocp4_app_node_count" {
  type    = string
  default = "3"
}

#############################################################################
## Template VM

variable "ocp4_template_vm_disk_size" {
  type    = string
  default = "32"
}
variable "ocp4_template_vm_memory_size" {
  type    = string
  default = "16384"
}
variable "ocp4_template_vm_cpu_count" {
  type    = string
  default = "4"
}

#############################################################################
## Bootstrap VM Configuration

variable "ocp4_bootstrap_disk_size" {
  type    = string
  default = "32"
}
variable "ocp4_bootstrap_memory_size" {
  type    = string
  default = "16384"
}
variable "ocp4_bootstrap_cpu_count" {
  type    = string
  default = "4"
}
#### Bootstrap VM - Network Options
variable "ocp4_bootstrap_vm_network_config" {
  type = map(any)
  default = {
    type      = "static"
    ip        = "192.168.42.90"
    subnet    = "255.255.255.0"
    gateway   = "192.168.42.1"
    interface = "ens192"
    server_id = ""
  }
}

#############################################################################
## Orchestrator/Master Nodes Configuration

variable "ocp4_orchestrator_cpu_count" {
  type    = string
  default = "4"
}
variable "ocp4_orchestrator_memory_size" {
  type    = string
  default = "16384"
}
variable "ocp4_orchestrator_disk_size" {
  type    = string
  default = "120"
}
#### Orchestrator/Master Nodes - Network Options
variable "ocp4_orchestrator_network_config" {
  type = map(any)
  default = {
    orchestrator_0_type      = "static"
    orchestrator_0_ip        = "192.168.42.91"
    orchestrator_0_subnet    = "255.255.255.0"
    orchestrator_0_gateway   = "192.168.42.1"
    orchestrator_0_interface = "ens192"
    orchestrator_0_server_id = ""

    orchestrator_1_type      = "static"
    orchestrator_1_ip        = "192.168.42.92"
    orchestrator_1_subnet    = "255.255.255.0"
    orchestrator_1_gateway   = "192.168.42.1"
    orchestrator_1_interface = "ens192"
    orchestrator_1_server_id = ""

    orchestrator_2_type      = "static"
    orchestrator_2_ip        = "192.168.42.93"
    orchestrator_2_subnet    = "255.255.255.0"
    orchestrator_2_gateway   = "192.168.42.1"
    orchestrator_2_interface = "ens192"
    orchestrator_2_server_id = ""
  }
}

#############################################################################
## Infrastructure Nodes Configuration

variable "ocp4_infra_node_cpu_count" {
  type    = string
  default = "4"
}
variable "ocp4_infra_node_memory_size" {
  type    = string
  default = "16384"
}
variable "ocp4_infra_node_disk_size" {
  type    = string
  default = "120"
}
#### Infrastructure Nodes - Network Options
variable "ocp4_infra_node_network_config" {
  type = map(any)
  default = {
    infra_node_0_type      = "static"
    infra_node_0_ip        = "192.168.42.94"
    infra_node_0_subnet    = "255.255.255.0"
    infra_node_0_gateway   = "192.168.42.1"
    infra_node_0_interface = "ens192"
    infra_node_0_server_id = ""

    infra_node_1_type      = "static"
    infra_node_1_ip        = "192.168.42.95"
    infra_node_1_subnet    = "255.255.255.0"
    infra_node_1_gateway   = "192.168.42.1"
    infra_node_1_interface = "ens192"
    infra_node_1_server_id = ""

    infra_node_2_type      = "static"
    infra_node_2_ip        = "192.168.42.96"
    infra_node_2_subnet    = "255.255.255.0"
    infra_node_2_gateway   = "192.168.42.1"
    infra_node_2_interface = "ens192"
    infra_node_2_server_id = ""
  }
}

#############################################################################
## Infrastructure Nodes Configuration

variable "ocp4_app_node_cpu_count" {
  type    = string
  default = "4"
}
variable "ocp4_app_node_memory_size" {
  type    = string
  default = "16384"
}
variable "ocp4_app_node_disk_size" {
  type    = string
  default = "120"
}
#### Application Nodes - Network Options
variable "ocp4_app_node_network_config" {
  type = map(any)
  default = {
    app_node_0_type      = "static"
    app_node_0_ip        = "192.168.42.97"
    app_node_0_subnet    = "255.255.255.0"
    app_node_0_gateway   = "192.168.42.1"
    app_node_0_interface = "ens192"
    app_node_0_server_id = ""

    app_node_1_type      = "static"
    app_node_1_ip        = "192.168.42.98"
    app_node_1_subnet    = "255.255.255.0"
    app_node_1_gateway   = "192.168.42.1"
    app_node_1_interface = "ens192"
    app_node_1_server_id = ""

    app_node_2_type      = "static"
    app_node_2_ip        = "192.168.42.99"
    app_node_2_subnet    = "255.255.255.0"
    app_node_2_gateway   = "192.168.42.1"
    app_node_2_interface = "ens192"
    app_node_2_server_id = ""
  }
}