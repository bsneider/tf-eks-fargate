variable "login_approle_role_id" {
  description = "role id for vault approle to generate aws creds"
}
variable "login_approle_secret_id" {
  description = "secret id for vault approle to generate aws creds"
}
variable "vault_addr" {
  description = "address of vault instance"
}
variable "vault_namespace" {
  description = "vault namespace"
  default     = "admin"
}
variable "environment" {
  description = "the name of your environment, e.g. \"dev\""
  default     = "dev"
}
