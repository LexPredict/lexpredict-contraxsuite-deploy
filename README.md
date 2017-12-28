# LexPredict ContraxSuite - Deploy Scripts
Deployment package for [LexPredict ContraxSuite](https://github.com/LexPredict/lexpredict-contraxsuite).

* Official Website: https://contraxsuite.com/
* LexPredict: https://lexpredict.com/
* [Installation and Configuration Guide](https://github.com/LexPredict/lexpredict-contraxsuite/blob/1.0/documentation/Installation%20and%20Configuration%20Guide.pdf)
* [Software and Data Dependencies](https://github.com/LexPredict/lexpredict-contraxsuite/blob/1.0/documentation/Software%20and%20Data%20Dependencies.pdf)

## Linux Deployments
Currently, only Ubuntu 16.04LTS installations are automated with this deployment package.  Please see the Public Roadmap for more information about automation on other operating systems or distributions.

### Local Machine Installation

* edit `base/fabricrc`
  * change database credentials if needed (optional)
  * set superuser's username, password, email (for v1.01)

* edit `local/fabricrc`
  * set user and sudo password if required
  * change `public_ip`, `dns_name`
  * `nginx_server_name` should be equal either `dns_name` (if https enabled) or `public_ip`
  * leave as is `"hosts = localhost"`
  * uncomment `"https_redirect"` if you use https
  * uncomment and set `"cert_email"` - use your email to produce ssl certificates if https enabled
  * set path for licensed JQ widgets zip file with `jqwidgets_zip_archive_path`
  * set path for licensed Canvas theme zip file with `theme_zip_archive_path`

* edit `local/local_setting.py`
  * set django's secret key
  * setup your email backend, e.g., sendgrid (optional)
  * set `ADMINS`
  
* confirm passwordless `ssh` to localhost
  * Generate new SSH key for local usage: `ssh-keygen -f ~/.ssh/id_rsa`
  * Add server keys to users known hosts: `ssh-keyscan -H localhost >> ~/.ssh/known_hosts`
  * Allow user to ssh to itself: `cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys`
  * Confirm local ssh without prompt: `ssh localhost`

* in terminal:
  * ` $ ./setup_local.sh | tee -a log.txt`


### Remote Machine Installation
* edit `base/fabricrc`
  * change database credentials if needed (optional)
  * set superuser's username, password, email (for v1.01)

* edit `remote/fabricrc`
  * set user (and password if needed)
  * change `public_ip`, `dns_name`
  * `nginx_server_name` should be equal either `dns_name` (https) or `public_ip`
  * uncomment `"https_redirect"` if you use https
  * uncomment and set `"cert_email"` - use your email to produce ssl certificates if https enabled

* edit `remote/local_setting.py`
  * set django's secret key
  * setup your email backend, e.g., sendgrid (optional)
  * set `ADMINS`

* **add your .pem key in `remote/` directory (to be able to ssh to your remote machine)**

* in terminal:
  * `$ ./setup_remote.sh | tee -a log.txt`


### Upgrade to Newest Release

* To upgrade from previous release, use
  `$ ./update_remote.sh` and `$ ./update_local.sh` accordingly.
   Note that you should use those commands in the same virtual environment you
   used to install the project before.
* To upgrade from release <= 1.0.3, use
  `$ ./update_remote.sh` and `$ ./update_local.sh` accordingly, 
  but note that you should uncomment lines with "rabbitmq_install" and 
  "elasticsearch_install" commands.
