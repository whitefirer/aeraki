#!/bin/bash

# Copyright Aeraki Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


#set -x

function LabelIstioInjectLabel() 
{  
    ns=$1
	echo $ns
	label=`kubectl get po -n istio-system  |grep istiod | awk '{print $1}'  |xargs kubectl get po  -o yaml  -n istio-system  |grep -A 1 REVIS |grep value:  |awk  '{print $2}'`
	echo $label
	if [ $label != "" ];then
		kubectl label namespace $ns istio.io/rev=$label --overwrite
	else 
		kubectl label namespace $ns istio-injection=enabled --overwrite=true
	fi
    return 0;  
}

