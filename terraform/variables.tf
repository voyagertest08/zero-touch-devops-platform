variable "app_name" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "hosted_zone_id" {
  type = string
}

variable "cluster_name" {
  default = "zero-touch-cluster"
}
