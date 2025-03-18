# Infrastructure variables
variable "aws_profile" {
  description = "AWS profile"
  type        = string
  default     = "default"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}


variable "default_root_object" {
  description = "Default root object for the CloudFront distribution"
  type        = string
  default     = "index.html"
}

# Required tag variables
variable "owner" {
  description = "Owner's develeap email (name.lastname@develeap.com)"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z]+\\.[a-z]+@develeap\\.com$", var.owner))
    error_message = "Owner must be a valid develeap email in the format name.lastname@develeap.com (lowercase)"
  }
}

variable "stage" {
  description = "Environment stage (production, dev, or test)"
  type        = string
  
  validation {
    condition     = contains(["production", "dev", "test"], var.stage)
    error_message = "Stage must be one of: production, dev, test"
  }
}

variable "project" {
  description = "Project name (must be descriptive)"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9_]+$", var.project)) && length(var.project) >= 3
    error_message = "Project name must be lowercase, use underscores, and be at least 3 characters long"
  }
}

variable "start_date" {
  description = "Project start date (dd/mm/yyyy)"
  type        = string
  
  validation {
    condition     = can(regex("^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\\d{4}$", var.start_date))
    error_message = "Start date must be in format dd/mm/yyyy"
  }
}

variable "end_date" {
  description = "Project end date (dd/mm/yyyy)"
  type        = string
  
  validation {
    condition     = can(regex("^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\\d{4}$", var.end_date))
    error_message = "End date must be in format dd/mm/yyyy"
  }
} 
variable "email" {
  description = "Owner's email"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}$", var.email))
    error_message = "Email must be a valid email address"
  }
}
variable "Objective" {
  description = "Objective of the project"
  type        = string
}

variable "region" {
  type = string
}