#!/bin/sh
CURR_DIR="${PWD}/$(dirname $0)";
cd ${CURR_DIR}/dependent-caret && rm -rf node_modules && npm install;
cd ${CURR_DIR}/dependent-star && rm -rf node_modules && npm install;
cd ${CURR_DIR}/dependent-tilda && rm -rf node_modules && npm install;