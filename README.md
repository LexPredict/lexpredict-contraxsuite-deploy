# lexpredict-contraxsuite-deploy
Deployment package for LexPredict ContraxSuite


##1. To setup on the same machine:

a) edit base/fabricrc
    - change database credentials if needed (optional)
    - set superuser's username, password, email (for v1.01)

   edit local/fabricrc
    - set user and sudo password
    - change public_ip, dns_name
    - nginx_server_name should be equal either dns_name (if https enabled) or public_ip
    - leave as is "hosts = localhost"
    - uncomment "https_redirect" if you use https
    - uncomment and set "cert_email" - use your email to produce ssl certificates if https enabled

   edit local/local_setting.py
    - set django's secret key
    - setup your email backend, f.e. sendgrid (optional)
    - set ADMINS

b) in terminal:
   . ./setup_local.sh

   or also log to a file
   . ./setup_local.sh | tee -a log.txt


##2. To setup on remote machine:

a) edit base/fabricrc
    - change database credentials if needed (optional)
    - set superuser's username, password, email (for v1.01)

   edit remote/fabricrc
    - set user (and password if needed)
    - change public_ip, dns_name
    - nginx_server_name should be equal either dns_name (https) or public_ip
    - uncomment "https_redirect" if you use https
    - uncomment and set "cert_email" - use your email to produce ssl certificates if https enabled

   edit remote/local_setting.py
    - set django's secret key
    - setup your email backend, f.e. sendgrid (optional)
    - set ADMINS

b) add your .pem key in remote/ directory (to be able to ssh to your remote machine)

c) in terminal:
   . ./setup_remote.sh

   or also log to a file
   . ./setup_remote.sh | tee -a log.txt
