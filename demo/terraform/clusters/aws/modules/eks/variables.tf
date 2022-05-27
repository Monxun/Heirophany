variable "vpc_name" {
  description = "The name of the VPC containing this stack."
  default     = "mg-eks-vpc"
}
variable "stack_name" {
  description = "The name of the Terraform stack"
  default     = "mg-aline-eks"
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "mg-aline-eks-cluster"
  sensitive   = false
}

variable "aws_region" {
  description = "The AWS region we would like to create our resources on."
  type        = string
  default     = "us-west-2"
  sensitive   = false
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.83.0.0/16"
}

variable "eks_private_subnets_cidr" {
  description = "Private subnets CIDR block list."
  default     = ["10.83.0.0/20", "10.83.32.0/20"]
}

variable "eks_public_subnets_cidr" {
  description = "Public subnets CIDR block list"
  default     = ["10.83.16.0/20", "10.83.48.0/20"]
}

variable "container_cpu" {
  description = "The number of CPU units used by the task."
  default     = 256
}

variable "container_memory" {
  description = "The amount of memory, in MiB, of memory used by the task."
  default     = 512
}

variable "k8_version" {
  description = "The version of Kubernetes we want to use for our EKS cluster."
  type        = string
  default     = "1.22"
}

variable "k8_service_namespace" {
  description = "The namespace we want to use for the K8 services which add functionality for our microservice deployments. (Ingress/Autoscaling)"
  type        = string
  default     = "kube-system"
}
variable "health_check_path" {
  description = "HTTP path for task health check."
  default     = "/health"
}