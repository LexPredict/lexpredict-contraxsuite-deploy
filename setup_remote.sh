#!/usr/bin/env bash
START_TIME="`date`"

if [ $(id -u) = 0 ]; then
    echo "This script is not meant to be run as the root user.   Please review the Installation Guide and execute as a non-root user."
    exit 1
fi
    
sudo apt-get update -y --fix-missing
sudo apt-get install -y python3-dev python-setuptools python-virtualenv python-pip

virtualenv -p python3 ve
source ve/bin/activate
pip install Fabric3==1.13.1.post1 fabtools-python==0.19.7 Jinja2==2.10.1

fab -c remote/fabricrc debian_install
fab -c remote/fabricrc locales_install
fab -c remote/fabricrc postgres_create
fab -c remote/fabricrc debian_upgrade_reboot
fab -c remote/fabricrc create_base_directory
fab -c remote/fabricrc python_install
fab -c remote/fabricrc redis_install
fab -c remote/fabricrc rabbitmq_install
fab -c remote/fabricrc java_install
fab -c remote/fabricrc elasticsearch_install

fab -c remote/fabricrc git_clone
fab -c remote/fabricrc create_dirs
fab -c remote/fabricrc theme_install
fab -c remote/fabricrc jqwidgets_install

#fab -c remote/fabricrc upload_templates
fab -c remote/fabricrc upload_template_and_reload:settings
fab -c remote/fabricrc upload_template_and_reload:502
fab -c remote/fabricrc upload_template_and_reload:uwsgi-init
fab -c remote/fabricrc upload_template_and_reload:uwsgi
fab -c remote/fabricrc upload_template_and_reload:settings
fab -c remote/fabricrc upload_template_and_reload:nginx

fab -c remote/fabricrc manage:force_migrate
fab -c remote/fabricrc manage:set_site
fab -c remote/fabricrc manage:collectstatic
fab -c remote/fabricrc manage:loadnewdata,fixtures/common/*.json
fab -c remote/fabricrc manage:loadnewdata,fixtures/private/*.json
fab -c remote/fabricrc create_superuser

fab -c remote/fabricrc nltk_download
fab -c remote/fabricrc ssl_install

# ensure all dirs created
fab -c remote/fabricrc create_dirs

fab -c remote/fabricrc start

END_TIME="`date`"

# Output timing stats
echo "Started: $START_TIME"
echo "Completed: $END_TIME"
