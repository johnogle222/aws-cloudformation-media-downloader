#!/usr/bin/env bash

# Get the directory of this file (where the package.json file is located)
bin_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

"${bin_dir}/build-node-modules.sh"

echo "Updating Terraform plan"
cd "${bin_dir}/../terraform"
terraform apply -auto-approve
