# server variables
variable "server_port" {
  description     = "port server will ust for http request"
  type            = number
  default         = 8080
}

# Ubuntu Server 20.04 LTS (HVM),EBS General Purpose (SSD) Volume Type. Support available from
# Canonical (http://www.ubuntu.com/cloud/services)
# free tier eligible
variable "server_ami" {
  description = "Ubuntu Server 20.04 LTS (HVM),EBS General Purpose (SSD)"
  type            = string
  default         = "ami-0a91cd140a1fc148a"
}

/*
 * legend: Gb == gigabit // GB == gigabyte
 * t2.micro is free tier eligible
 * starting at t3 network connectivity goes up to 5Gb
 * t3 option considerations - any higher performance instances require cost research!
 * alternative t3.nano(vCPUS = 2, Memory = 0.5 B)
 * alternative t3.micro(vCPUS = 2, Memory = 1GB)
 * alternative t3.na(vCPUS = 2, Memory = 2GB)
 */
variable "server_instance_type" {
  description = "t2.micro	vCPU=1	CPU credit/hr=6	mem=1GiB storage=EBS-Only network=Low to Moderate"
  type            = string
  default         = "t2.micro"
}

