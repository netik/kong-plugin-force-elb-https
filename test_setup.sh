#!/bin/bash
# 
# Bootstrap the Kong API Gateway with routes for testing
# 
# J. Adams <john@twothink.co>
# 10/18/2019
#

# Kong's admin port, only accessible from localhost on the api servers
APORT=8001

#curl -i -X POST \
#  --url http://localhost:$APORT/services/ \
#  --data 'name=testy' \
#  --data "url=http://localhost:9000"

#curl -i -X POST \
#    --url http://localhost:$APORT/services/testy/routes \
#    --data-urlencode "hosts[]=localhost"

curl -i -X POST \
     --url http://localhost:$APORT/services/testy/plugins \
     --data "name=force-elb-https" \
     --data "config.strip_uri=false" \
     --data "config.redirect_to=domain.com"





