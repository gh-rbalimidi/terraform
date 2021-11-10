
variable "queue_name" {
  type        = string
  default     = "samba_sqs"
}

variable "visibility_timeout_seconds" {
  type        = number
  description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30."
  default     = 30
}

variable "message_retention_seconds" {
  type        = number
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days)"
  default     = 345600
}

variable "max_message_size" {
  type        = number
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB)"
  default     = 262144
}

variable "delay_seconds" {
  type        = number
  description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds"
  default     = 0
}

variable "receive_wait_time_seconds" {
  type        = number
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately"
  default     = 0
}


variable "fifo_queue" {
  type        = bool
  description = "Boolean designating a FIFO queue. If not set, it defaults to false making it standard. This will append the required extension `.fifo` to the queue name"
  default     = false
}

variable "content_based_deduplication" {
  type        = bool
  description = "Enables content-based deduplication for FIFO queues"
  default     = false
}

variable "deduplication_scope" {
  type        = string
  description = "Specifies whether message deduplication occurs at the message group or queue level. Valid values are `messageGroup` and `queue` (default)"
  default     = null
}

variable "fifo_throughput_limit" {
  type        = string
  description = "Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. Valid values are `perQueue` (default) and `perMessageGroupId`"
  default     = null
}


variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the queue"
  default     = null
}