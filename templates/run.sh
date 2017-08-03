#!/bin/bash

cd %(project_dir)s
source %(ve_bin)s/activate
if [ $1 ]; then
    if [ $1 = "s" ]; then
        python manage.py shell
    elif [ $1 = "sp" ]; then
        python manage.py shell_plus
    elif [ $1 = "n" ]; then
        python manage.py shell_plus --notebook
    elif [ $1 = "r" ]; then
        python manage.py runserver
    elif [ $1 = "rp" ]; then
        python manage.py runserver_plus
    elif [ $1 = "psql" ]; then
        PGPASSWORD=%(db_password)s psql -U%(db_user)s -h%(db_host)s -p%(db_port)s %(db_name)s
    fi
fi