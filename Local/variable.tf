variable "content" {
  type        = string
  description = "Contents"
  validation {
    condition     = substr(var.content, 0, 10) == "content - "
    error_message = "contents should start with content - "
  }

}
