variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "cluster_name" {
  default = "bankapi-cluster"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "cluster_version" {
  default = "1.23"
}

variable "namespace" {
  default = "bankapi"
}

variable "secret" {
  default = "bankapi-secret"
}