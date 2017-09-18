#!/usr/bin/env bash
START_TIME="`date`"

sudo apt-get update -y --fix-missing
sudo apt-get install -y python3-dev python-setuptools python-virtualenv python-pip

virtualenv -p python3 ve
source ve/bin/activate
pip install Fabric3==1.13.1.post1 fabtools-python==0.19.7 Jinja2==2.9.5

fab -c remote/fabricrc debian_install
fab -c remote/fabricrc locales_install
fab -c remote/fabricrc postgres_create
fab -c remote/fabricrc debian_upgrade_reboot
fab -c remote/fabricrc create_base_directory
fab -c remote/fabricrc python_install
fab -c remote/fabricrc redis_install
fab -c remote/fabricrc java_install
fab -c remote/fabricrc elasticsearch_install

fab -c remote/fabricrc git_clone
fab -c remote/fabricrc create_dirs
fab -c remote/fabricrc upload_templates
fab -c remote/fabricrc manage:force_migrate
fab -c remote/fabricrc manage:update_index
fab -c remote/fabricrc manage:set_site
fab -c remote/fabricrc manage:collectstatic
fab -c remote/fabricrc nltk_download
fab -c remote/fabricrc ssl_install
fab -c remote/fabricrc start

#v1.01
fab -c remote/fabricrc create_superuser

END_TIME="`date`"

# Output timing stats
echo "Started: $START_TIME"
echo "Completed: $END_TIME"
