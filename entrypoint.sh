#!/bin/bash
cd /home/container

if [ -z "$(ls -A /home/container)" ]; then
  echo "directory found to be Empty"
  git clone https://github.com/braddevans/pter-nodejs-pnpm-egg.git /tmp/egg
  ls -lash /tmp/egg/
  cp /tmp/egg/container/* . -v
else
  echo "Not Empty"
fi

node -v

SHOULD_INSTALL=true
SHOULD_USE_PNPM=false
NPM_COMMAND="i"
NODE_START_FILE="run server"

function run_pnpm() {
  NPM_PACKAGE_INSTALLER="pnpm {{NPM_COMMAND}}"
  MODIFIED_NPM_PACKAGE_INSTALLER=$(eval echo $(echo ${NPM_PACKAGE_INSTALLER} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
  echo ":/home/container$ ${MODIFIED_NPM_PACKAGE_INSTALLER}"

  # Run the npm command
  ${MODIFIED_NPM_PACKAGE_INSTALLER}
}

function run_npm() {
  NPM_PACKAGE_INSTALLER="npm {{NPM_COMMAND}}"
  MODIFIED_NPM_PACKAGE_INSTALLER=$(eval echo $(echo ${NPM_PACKAGE_INSTALLER} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
  echo ":/home/container$ ${MODIFIED_NPM_PACKAGE_INSTALLER}"

  # Run the npm command
  ${MODIFIED_NPM_PACKAGE_INSTALLER}
}

function run_server() {
  NPM_START="npm {{NODE_START_FILE}}"
  if [ "$SHOULD_USE_PNPM" = "true" ]; then
    NPM_START="pnpm {{NODE_START_FILE}}"
  fi
  MODIFIED_NPM_START=$(eval echo $(echo ${NPM_START} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
  echo ":/home/container$ ${MODIFIED_NPM_START}"

  # Run the Server
  ${MODIFIED_NPM_START}
}

if [ "${SHOULD_INSTALL}" = "true" ]; then
  if [ "$SHOULD_USE_PNPM" = "true" ]; then
    # run pnpm command
    run_pnpm
  elif [ "$SHOULD_USE_PNPM" = "false" ]; then
    # run node command
    run_npm
  fi
fi

# run server
run_server
