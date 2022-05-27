#!/usr/bin/env bash
set -e

alias awsvt="aws-vault exec profile -- terraform"

source vars.sh
source ./resources/deploy_backend.sh
source config_backend.sh