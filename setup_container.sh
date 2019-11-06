#!/usr/bin/bash

function start {
  set -e
  local ip port password
  sudo docker run -dt --rm --name jenkins-master jenkins/jenkins:${VERSION:-lts-alpine}
  echo 'Waiting for Jenkins to start...'
  until sudo docker logs jenkins-master | grep -q 'INFO: Jenkins is fully up and running'; do
    sleep 1
  done
  ip=$(sudo docker inspect --format='{{.NetworkSettings.IPAddress}}' jenkins-master)
  password=$(sudo docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword)
  port=8080
  cat <<EOF | tee jenkins_env
URL='http://${ip}:${port}'
USER='admin'
PASSWORD='${password}'
EOF
}

function stop {
  sudo docker stop jenkins-master
}

"$@"