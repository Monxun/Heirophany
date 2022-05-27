# MODULE: AWS BACKEND - NIGHTWALKERS - STATIC RESOURCES

Description: 
    Shared terraform state backend for Nightwalkers IAC

# VARIABLES / SOURCE
- region : TF_VAR env
- availabilityZone : TF_VAR env
- instanceTenancy : TF_VAR env
- dnsSupport : TF_VAR env
- dnsHostNames : TF_VAR env
- vpcCIDRblock : TF_VAR env
- subnetCIDRblock : TF_VAR env
- destinationCIDRblock : TF_VAR env
- ingressCIDRblock : TF_VAR env
- egressCIDRblock : TF_VAR env
- mapPublicIP : TF_VAR env

# RESOURCE ID'S
- vpc_id
- vpc_subnet_id
- vpc_security_group_id
- vpc_security_acl_id
- vpc_internet_gateway_id
- vpc_route_table_id
- vpc_internet_access_route_id
- vpc_route_table_association_id

////////////////////////////////////////////////////////////////////////
# RESOURCE DETAILS: