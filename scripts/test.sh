#!/bin/bash

ROOT="$(pwd)"
NDC_TEST_VERSION=v0.1.3

http_wait() {
  printf "$1:\t "
  for i in {1..60};
  do
    local code="$(curl -s -o /dev/null -m 2 -w '%{http_code}' $1)"
    if [[ $code != "200" ]]; then
      printf "."
      sleep 1
    else
      printf "\r\033[K$1:\t ${GREEN}OK${NC}\n"
      return 0
    fi
  done
  printf "\n${RED}ERROR${NC}: cannot connect to $1. Please check service logs with command:\n"
  echo "  docker-compose logs -f $2"
  exit 1
}

# download ndc-test
if [ ! -f "$ROOT/tmp/ndc-test" ]; then 
  mkdir -p tmp
  curl -L "https://github.com/hasura/ndc-spec/releases/download/$NDC_TEST_VERSION/ndc-test-x86_64-unknown-linux-gnu" -o "$ROOT/tmp/ndc-test"
  chmod +x "$ROOT/tmp/ndc-test"
fi

cp .env.example .env
DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker compose up -d
http_wait http://localhost:8080/health
http_wait http://localhost:4444/health/alive
http_wait http://localhost:4445/health/ready

sleep 5
$ROOT/tmp/ndc-test test --endpoint http://localhost:8080
# $ROOT/tmp/ndc-test replay --endpoint http://localhost:8080 --snapshots-dir $ROOT/testdata/01-setup
# $ROOT/tmp/ndc-test replay --endpoint http://localhost:8080 --snapshots-dir $ROOT/testdata/02-getData
# $ROOT/tmp/ndc-test replay --endpoint http://localhost:8080 --snapshots-dir $ROOT/testdata/03-cleanup

exit_code=$?
docker compose down --remove-orphans -v
exit $exit_code