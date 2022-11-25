variable "public_key" {
  type        = string
  description = "File path of public key."
  default     = "~/.ssh/"
}

variable "private_key" {
  type        = string
  description = "File path of private key."
  default     = "~/.ssh/"
}
