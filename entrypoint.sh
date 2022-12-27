#!/bin/bash
cd /home/container

if [ -z "$(ls -A /home/container)" ]; then
   echo "Empty";
   cp /tmpstore/container/. . -v;
else
   echo "Not Empty"
fi

node -v

SHOULD_INSTALL=true
NPM_COMMAND="i"
NODE_START_FILE="run server"

function run_npm() {
  NPM_PACKAGE_INSTALLER="pnpm {{NPM_COMMAND}}"
  MODIFIED_NPM_PACKAGE_INSTALLER=$(eval echo $(echo ${NPM_PACKAGE_INSTALLER} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
  echo ":/home/container$ ${MODIFIED_NPM_PACKAGE_INSTALLER}"

  # Run the npm command
  ${MODIFIED_NPM_PACKAGE_INSTALLER}
}


function run_server() {
  NPM_START="pnpm {{NODE_START_FILE}}"
  MODIFIED_NPM_START=$(eval echo $(echo ${NPM_START} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
  echo ":/home/container$ ${MODIFIED_NPM_START}"

  # Run the Server
  ${MODIFIED_NPM_START}
}

if [ "$SHOULD_INSTALL" = "true" ]; then
  # run npm command
  run_npm
fi

# run server
run_server
