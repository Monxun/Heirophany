# ANSIBLE TODO
Pull in playbooks -> export as local variable for each stage of playbooks

<!-- REGISTER MULTIPLE VARIABLES IN ONE TASK -->
https://stackoverflow.com/questions/46608715/ansible-register-multiple-variables-within-a-single-task

<!-- SCHEDULE DOWN RESOURCES -->
https://aws.amazon.com/premiumsupport/knowledge-center/start-stop-lambda-eventbridge/

<!-- TERRAFORM CHEATSHEET -->
https://acloudguru.com/blog/engineering/the-ultimate-terraform-cheatsheet

<!-- SERVICE LOAD BALANCING -->
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-load-balancing.html


# TERRAFORM COMMANDS

terraform review

<!-- OUTPUT GRAPH OF TERRAFORM PLAN -->
terraform graph | dot -Tpng > graph.png

<!-- OUTPUT ALL TERRAFORM RESOURCES-->
terraform state list

<!-- OUTPUT TERRAFORM PLAN-->
terraform plan -out plan.out

<!-- FORMATS TERRAFORM FILES-->
terraform fmt

<!-- GRAB STATE DETAILS FOR SPECIFIC RESOURCES-->
terraform state show aws_instance.my_ec2