#!/usr/bin/env bash

set -e -x

source bosh-cpi-release/ci/tasks/utils.sh

check_param base_os
check_param network_type_to_test

cpi_release_name=bosh-vcloud-cpi

manifest_dir=bosh-concourse-ci/pipelines/$cpi_release_name
state_filename=${base_os}-${network_type_to_test}-director-manifest-state.json

echo "checking in BOSH deployment state"
cp deploy/tmp/${state_filename} deploy/${manifest_dir}/${state_filename}
cd deploy/${manifest_dir}
git add ${state_filename}
git config --global user.email "cf-bosh-eng+bosh-ci@pivotal.io"
git config --global user.name "bosh-ci"
git commit -m ":airplane: Concourse auto-updating deployment state for bats pipeline, on $base_os/$network_type_to_test"