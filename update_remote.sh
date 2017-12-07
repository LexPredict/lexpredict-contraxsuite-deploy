#!/usr/bin/env bash
START_TIME="`date`"

if [ $(id -u) = 0 ]; then
    echo "This script is not meant to be run as the root user.   Please review the Installation Guide and execute as a non-root user."
    exit 1
fi

#sudo apt-get update --fix-missing
#sudo apt-get install python3-dev python-setuptools python-virtualenv python-pip

#virtualenv -p python3 ve
source ve/bin/activate
#pip install Fabric3==1.13.1.post1 fabtools-python==0.19.7 Jinja2==2.9.5

fab -c remote/fabricrc stop

# for those cases when application name was changed kill all "-A apps" celery workers
fab -c local/fabricrc stop_celery:kill_process=1

fab -c remote/fabricrc python_install
fab -c remote/fabricrc rabbitmq_install
fab -c remote/fabricrc elasticsearch_install

fab -c remote/fabricrc git_pull

#fab -c remote/fabricrc upload_templates
fab -c remote/fabricrc manage:migrate
fab -c remote/fabricrc manage:collectstatic

fab -c remote/fabricrc start

END_TIME="`date`"

# Output timing stats
echo "Started: $START_TIME"
echo "Completed: $END_TIME"
