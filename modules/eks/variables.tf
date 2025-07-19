variable "cluster_name" {
  description = "Name of EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Version of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the EKS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)

}

variable "node_group_name" {
  description = "EKS node group config"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      min_size     = number
      max_size     = number
      desired_size = number
    })
  }))

}
