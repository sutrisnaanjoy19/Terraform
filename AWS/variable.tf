variable "ami" {
  default     = "ami-04b70fa74e45c3917"
  description = "Ubuntu Server 24.04 LTS (HVM), SSD Volume Typ"
}
variable "open_ports" {
  type    = set(any)
  default = ["80", "443", "22"]
}
