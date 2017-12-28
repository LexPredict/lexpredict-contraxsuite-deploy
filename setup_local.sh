#!/usr/bin/env bash
START_TIME="`date`"

if [ $(id -u) = 0 ]; then
    echo "This script is not meant to be run as the root user.   Please review the Installation Guide and execute as a non-root user."
    exit 1
fi

sudo apt-get update --fix-missing
sudo apt-get install python3-dev python-setuptools python-virtualenv python-pip

virtualenv -p python3 ve
source ve/bin/activate
pip install Fabric3==1.13.1.post1 fabtools-python==0.19.7 Jinja2==2.9.5

fab -c local/fabricrc debian_install
fab -c local/fabricrc locales_install
fab -c local/fabricrc postgres_create
fab -c local/fabricrc create_base_directory
fab -c local/fabricrc python_install
fab -c local/fabricrc rabbitmq_install
fab -c local/fabricrc java_install
fab -c local/fabricrc elasticsearch_install

fab -c local/fabricrc git_clone
fab -c local/fabricrc create_dirs
fab -c local/fabricrc theme_install
fab -c local/fabricrc jqwidgets_install

#fab -c local/fabricrc upload_templates
fab -c local/fabricrc upload_template_and_reload:settings
fab -c local/fabricrc upload_template_and_reload:502
fab -c local/fabricrc upload_template_and_reload:uwsgi-init
fab -c local/fabricrc upload_template_and_reload:uwsgi
fab -c local/fabricrc upload_template_and_reload:settings
fab -c local/fabricrc upload_template_and_reload:nginx

fab -c local/fabricrc manage:force_migrate
fab -c local/fabricrc manage:set_site
fab -c local/fabricrc manage:collectstatic
fab -c local/fabricrc create_superuser

fab -c local/fabricrc nltk_download
fab -c local/fabricrc ssl_install

fab -c local/fabricrc start

END_TIME="`date`"

# Output timing stats
echo "Started: $START_TIME"
echo "Completed: $END_TIME"
