#!/bin/sh

git clone git@github.com:mantl/terraform.py.git
pipsi install terraform.py # basically, it needs to be on your path when you run ansible
<edit a script in your inventory directory to include the below shell script>