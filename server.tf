# set-up default launch server
resource "aws_launch_configuration" "elluis_server" {
//  aws ami image id
  image_id = var.server_ami
//  instance type ie t2.micro
  instance_type = var.server_instance_type

  security_groups = [aws_security_group]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF


}
resource "aws_instance" "example" {
  # image aws ami
  ami = "ami-0c55b159cbfafe1f0"
  # t2.micro (free tier)
  instance_type = "t2.micro"
  associate_public_ip_address = true

  # place the server inside elluis_server security group
  vpc_security_group_ids = [
    aws_security_group]



  # this will create and serve index.html file
  # via built in ubuntu 16 lts server

  # notice that the server busy box commands are wrapped
  # by nohub commands are -here -yep -ok &
  # this allows the server to run permanently in
  # in the background but exit out of the bash script

  # EOF is terraform multi-line comment without having
  # to insert multiple /n
  user_data = <<-EOF
                #!/bin/bash
                echo "hello, elluis" > index.html
                nohub busybox httpd -f -p ${var.server_port}  &
                EOF
  tags = {
    "Name" = "elluis_server"
  }
}