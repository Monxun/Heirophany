# MODULE: AWS APPLICATION LOAD BALANCER - NIGHTWALKERS - STATIC RESOURCES

Description: 
    Shared application load balancer for Nightwalkers team deployments and http/s request routing

    https://github.com/HDE/terraform-aws-alb/tree/v6.3.0/examples/complete-alb

    https://shinglyu.com/web/2019/01/29/multi-region-domain-names-and-load-balancing-with-aws-route53.html

# VARIABLES / SOURCE
- db_identifier : TF_VAR env
- db_engine : TF_VAR env
- db_name : TF_VAR env
- db_username : TF_VAR env
- db_password : TF_VAR env

# RESOURCE ID'S
- aline_db_id

////////////////////////////////////////////////////////////////////////
# RESOURCE DETAILS: