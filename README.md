== this is a learning project for me ==

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
                   
                   production: ?? not yet implemented !! production in this sense - best of what I have - mainly without comments to reduce clutter !! 
                   (may never be implemented (rofl))
                        
                   staging: construction of production environment
                        
                   developement: low cost server environment
                    
                        
            
        *************                
        staging_build == items preceeded with ?? == not yet implemented
        *************
        
        ***
        notes: Terraform module tag system is used to for several purposes:
                    * It will dynamically add the 'Name' tag to each resource built ie tag = { Name = "elluis_codes_us-east-2a_" }
        ***
        
        deployment_platform :                                               
                            AWS:
                                created_resources:
                                                     -vpc:
                                                     
                                                        -nat_gateway:
                                                        -internet_gateway:
                                                        ??-elastic_load_balancer:
                                                          ??  -target_groups
                                                        ??-DynamoDB
                                                        ??-RDS
                                                        ??-auto_scaling:
                                                            ??-auto_scaling_groups:
                                                                ??groups:( ??tbd )
                                                        -subnets:
                                                            -public_subnet:                                                    
                                                                -public_route_tables = elluis_public_route_table:
                                                                    -internet_gateway = elluis_internet_gateway
                                                            -private_subnet:
                                                                -private_route_tables:
                                                                    routes:
                                                                        from: nat_gateway to public_subnet
                                                                        from: public_subnet to nat_gateway

                                                                        
    
        !! construction_zone !!
        
        ##################################################### a few notes ######################################################
        # if you see an empty comment space ie.
        # it is usually because the function/resource/variable/etc explains itself
        # there is quite a few topics
        ########################################################################################################################
        ***************** there are some pretty specific explanations regarding a few of the trickier aspects ******************
        #   having said that - there will be a few conventions that carry on throughout the code explanations for these will   #
        #                                            declared in this block                                                    #
    
                                            :: topics are in order of construction ::
                                            
                                            
        _one_ ::  tagging_system:
                  explanation of tagging system can be found in _3_vpc_structure.tf // TODO :: combine explanation with documentation
                  tags are used to implement the following properties during terraform construction:
                        vpc name
                        create one private && public subnet in each available availability zone according to selected region
                        name each subnet as follows: (vpc), (region+availability zone), (tag designating public or private subnet)
                        dynamically assign ip address ranges to given subnets
                        create one private and public route table in vpc
                        name each route table following explained conventions
              
              
        _two_ ::    file layout is numbered according to the way I roughly picture the the entire network infrastructures order
                    order of operations. most directions within comments will point to _**_ said location 
                    
                    
                    
        STATUS::   {
        
                   {
        
        
                    currently waiting on DNS certificate validation to setup up a load balancer with our eip
                        - had a few issues with Namecheap’s interface - think i figured it out 
                        - still waiting on validation... //1224201037elluis
                        
                    going to put this build on pause at the moment
                    wanted to catch up on some documentation before focusing on my plain developer setup really want to delve back into the front end
                    for a moment to break up the monotony of the project
                    
                    setup a todoist project reminder == 12.28.20 to continue work on this section
                        btw :: look into ways to incorporate todoist further into the project developement cycle
                                           
                    }.nothing_follows
                    
                    
                    }.122420elluis

                    
                    
         
        TODO :: reformat docs ( from comments -> this read.me (current) -> html format ) to html format
        TODO :: implement missing resource ??items
        TODO :: setup server image - ??(amazon-linux-2 || ubuntu 20.* lts server)??
        TODO ::  
                                                                        
                                
                                    
        
        
