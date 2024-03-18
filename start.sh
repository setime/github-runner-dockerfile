#!/bin/bash

REPOSITORY=$REPO
ACCESS_TOKEN=$TOKEN

echo "REPO ${REPOSITORY}"
echo "ACCESS_TOKEN ${ACCESS_TOKEN}"
echo "LABLE ${LABEL}"

cd /home/docker/actions-runner

echo "Configure:"
./config.sh --url ${REPOSITORY} --token ${ACCESS_TOKEN} --labels ${LABEL} --unattended --replace

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

echo "Run:"
./run.sh & wait $!