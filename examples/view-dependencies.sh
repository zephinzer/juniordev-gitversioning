#!/bin/sh
CURR_DIR="${PWD}/$(dirname $0)";
cd ${CURR_DIR}/dependent-caret && printf "dependency-caret -> " && cat node_modules/juniordev-gitversioning-dependency/package.json | jq '.version';
cd ${CURR_DIR}/dependent-star && printf "dependency-star -> " && cat node_modules/juniordev-gitversioning-dependency/package.json | jq '.version';
cd ${CURR_DIR}/dependent-tilda && printf "dependency-tilda -> " && cat node_modules/juniordev-gitversioning-dependency/package.json | jq '.version';