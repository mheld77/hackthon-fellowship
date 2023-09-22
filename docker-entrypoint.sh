#!/bin/sh

# set default values for configuration
if [ -z "$CONFIGURATION_PROTOCOL" ]
then
    CONFIGURATION_PROTOCOL="http"
fi

if [ -z "$CONFIGURATION_HOSTNAME" ]
then
    CONFIGURATION_HOSTNAME="localhost"
fi

if [ -z "$CONFIGURATION_PORT" ]
then
    CONFIGURATION_PORT="9001"
fi

# set default values for auth
if [ -z "$AUTH_PROTOCOL" ]
then
    AUTH_PROTOCOL="http"
fi

if [ -z "$AUTH_HOSTNAME" ]
then
    AUTH_HOSTNAME="localhost"
fi

if [ -z "$AUTH_PORT" ]
then
    AUTH_PORT="9003"
fi

# set default values for soap
if [ -z "$SOAP_PROTOCOL" ]
then
    SOAP_PROTOCOL="http"
fi

if [ -z "$SOAP_HOSTNAME" ]
then
    SOAP_HOSTNAME="localhost"
fi

if [ -z "$SOAP_PORT" ]
then
    SOAP_PORT="9006"
fi


#replace env.js file with S.O. ENVs

cat <<EOF > /usr/share/nginx/html/env.js

(function (window) {
  window.__env = window.__env || {};

  // API url
  window.__env.INTEGRADOR_MAPPING_API = '$CONFIGURATION_PROTOCOL://$CONFIGURATION_HOSTNAME:$CONFIGURATION_PORT';
  window.__env.AUTH_API = '$AUTH_PROTOCOL://$AUTH_HOSTNAME:$AUTH_PORT';
  window.__env.SOAP_API = '$SOAP_PROTOCOL://$SOAP_HOSTNAME:$SOAP_PORT';

}(this));

EOF

exec "$@"
