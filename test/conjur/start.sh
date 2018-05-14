#!/bin/bash -ex

docker-compose build
docker-compose up -d conjur
docker-compose exec -T conjur conjurctl wait

admin_api_key=$(docker-compose exec -T conjur conjurctl role retrieve-key dev:user:admin | tr -d '\r')
export CONJUR_AUTHN_API_KEY=$admin_api_key

conjur_host_port=$(docker-compose port conjur 80)
conjur_port=$(docker run --rm \
  -v $PWD/../util/:/util/ \
  -e conjur_host_port=$conjur_host_port \
  golang:1.9-stretch bash -c "
  echo \"$conjur_host_port\" | go run /util/parse_port.go
  ")

rm -rf tmp
mkdir -p tmp

cat <<ENV > .env
CONJUR_APPLIANCE_URL=http://localhost:$conjur_port
CONJUR_ACCOUNT=dev
CONJUR_AUTHN_LOGIN=admin
CONJUR_AUTHN_API_KEY=$admin_api_key
ENV

docker-compose up -d secretless

sleep 2

docker-compose run \
  --rm \
  --no-deps \
  -e http_proxy=http://secretless:80 \
  test conjur variable values add db/password secret
