#!/bin/bash

################################################################
# Module to deploy IBM Cloud Private
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an “AS IS” BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Licensed Materials - Property of IBM
#
# Copyright (C) 2019 IBM Corporation
#
# Yussuf Shaikh <yussuf@us.ibm.com> - Initial implementation.
#
################################################################

# Set HOME env var, populate systemArch, helm init and cloudctl login
function clean_mcm_load {
    export HOME=~
    cd $HOME
    export HELM_HOME=~/.helm

    helm init --client-only
    cloudctl login -a https://${HUB_CLUSTER_IP}:8443 --skip-ssl-validation \
        -u ${icp_admin_user} -p ${icp_admin_user_password} -n kube-system

    cloudctl catalog delete-chart --name ibm-mcm-prod
    cloudctl catalog delete-chart --name ibm-mcmk-prod
}


HUB_CLUSTER_IP=$1
icp_admin_user=$2
icp_admin_user_password=$3

/bin/echo
/bin/echo "Cleaning MCM Load.."

clean_mcm_load
/bin/echo "MCM Load cleaning completed"
