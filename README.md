# elluis_dot_terraform
web application and structure build out using terraform to build out network infrastructure - ansible for application deployment


  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  the following code will resource will call on the gateway provisioner to assign the gateways to each private subnet

  disabled to do cost vs stage of development

  current strategy is to not use private subnet structure (yet)
  instead we will be provisioning an rds instance and serving a command single command ec2 instance

  ______________________________________________________________________________________________________________________
 ?? diagram for eample only
 in this example we would create an db instance in each private subnet to serve the application
 in each availability zone
 the commented out portions represent the currently commented out functionality described above

 -vpc:
  -subnets:
    -public_subnet:
      -public_route_tables:
    -private_subnet:
      -private_route_tables:
        #from: nat_gateway to public_subnet
        #from: public_subnet to nat_gateway

    instead (to save money during development) ::
  deactivate:
    nat implementation
  activate:
    underlying substructure ( private subnets , etc )
    one rds instance that will serve one private subnet us-east-2c

  during application developement:
    this subnet will have a developer instance for application deployment and delegate rds and web
    server communications

server-us-east2c <----------> developer-instance <----------> rds-instance

  ______________________________________________________________________________________________________________________
  
