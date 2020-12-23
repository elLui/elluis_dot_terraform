elluis-blog ingrastructure Terraform build - 

:: intended to be the main deployment build upon completion of blog-project ::

    intent  : build an AWS infrastructure that supports a hobby project blog website
    
    tools   :
        build_resources     :   Terraform - Ansible - AWSCLI - tbd 
                                # ( depending on final deployment schema - may decide to eventually incorporate Docker as our final deployment container ie.
                                # ((python_pip_flask_etc)(gradle_builder))--->to--->server_deployment
                                
        ******************* about versions *******************
        
        all created resources elluis_* will be denoted as elluis_v*_(*(developement/staging/production))_(*(ie. internet_gateway, public_subnet))
            example: elluis_v1.2_production_internet_gateway))
            
        versions: each version of this project will be seperated into its own repository
            - reason: due such significant variances for each environment -- environments along with summary of environment follow:
            
                environments:
                    
                        production: ?? not yet implemented !! production in this sense - means the best of what I have - mainly without comments to reduce clutter !!
                        
                        staging: construction of production environment
                        
                        developement: low cost server environment
                    
                        
            
                        
        
        
        deployment_platform :                                               
                            AWS:
                                created_resources:
                                                     -vpc:
                                                     
                                                        -nat_gateway:
                                                        -internet_gateway:
                                                        -elastic_load_balancer:
                                                            -target_groups
                                                        -DynamoDB
                                                        -RDS
                                                        -auto_scaling:
                                                            -auto_scaling_groups:
                                                                groups:( ??tbd )
                                                        -subnets:
                                                            -public_subnet:                                                    
                                                                -public_route_tables = elluis_public_route_table:
                                                                    -internet_gateway = elluis_internet_gateway
                                                            -private_subnet:
                                                                -private_route_tables:
                                                                    routes:
                                                                        from: nat_gateway to public_subnet
                                                                        from: public_subnet to nat_gateway

                                
                                    
        
        
