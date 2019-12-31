#!/bin/bash
source /etc/profile.d/instruqt-env.sh
source /root/.bashrc
/bin/set-workdir /root/hashicat-aws

# Get our TFC token and organization from the local config files
TOKEN=$(grep token /root/.terraformrc | cut -d '"' -f2)
ORG=$(grep organization /root/hashicat-aws/remote_backend.tf | cut -d '"' -f2)

POLICY=$(curl -s --header "Authorization: Bearer $TOKEN"   https://app.terraform.io/api/v2/organizations/$ORG/policy-sets | jq -r '.data | .[] | .attributes.name')

[[ $POLICY == "tfc-workshops-sentinel" ]] || fail-message "Uh oh, it looks like you haven't attached the tfc-workshops-sentinel policy set to your organization. Make sure you have forked the repo and added the policy set to your organization."
