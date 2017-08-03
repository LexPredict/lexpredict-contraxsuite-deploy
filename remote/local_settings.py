
# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'your-secret-key'

AUTOLOGIN = False

HOST_NAME = '%(host)s'
DEBUG = False
DEBUG_SQL = False
DEBUG_TEMPLATE = False

# email backend
#EMAIL_BACKEND = 'smtp.CustomEmailBackend'
#EMAIL_USE_TLS = True
#EMAIL_HOST = 'smtp.sendgrid.net'
#EMAIL_HOST_USER = 'your-user'
#EMAIL_HOST_PASSWORD = 'your-password'
#EMAIL_PORT = 587

EMAIL_PORT = 1025
EMAIL_HOST = 'localhost'
EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'

ADMINS = (
    ('Example, LLC', 'it@example.com'),
    ('Someone Else', 'someone-else@example.com'),
)

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.%(db_driver)s',
        'NAME': '%(db_name)s',
        'USER': '%(db_user)s',
        'PASSWORD': '%(db_password)s',
        'HOST': '%(db_host)s',
        'PORT': '%(db_port)s',
    },
}

ALLOWED_HOSTS = (
    '127.0.0.1',
    'localhost',
    '%(host)s',
    '%(public_ip)s',
)

INTERNAL_IPS = (
    '127.0.0.1',
    '%(host)s'
)
