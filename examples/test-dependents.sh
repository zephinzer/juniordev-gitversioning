#!/bin/sh
CURR_DIR="${PWD}/$(dirname $0)";

printf "\e[1m\e[32m";
cd ${CURR_DIR}/dependent-tilda && printf -- "\ndependency version: $(cat node_modules/juniordev-gitversioning-dependency/package.json | jq '.version') from $(cat package.json | jq '.dependencies."juniordev-gitversioning-dependency"')\n";
read -p 'hit enter to continue... ' DONE;
printf "\e[0m";
npm test;


printf "\e[1m\e[32m";
cd ${CURR_DIR}/dependent-caret && printf -- "\ndependency version: $(cat node_modules/juniordev-gitversioning-dependency/package.json | jq '.version') from $(cat package.json | jq '.dependencies."juniordev-gitversioning-dependency"')\n";
read -p 'hit enter to continue... ' DONE;
printf "\e[0m";
npm test;

printf "\e[1m\e[32m";
cd ${CURR_DIR}/dependent-star && printf -- "\ndependency version: $(cat node_modules/juniordev-gitversioning-dependency/package.json | jq '.version') from $(cat package.json | jq '.dependencies."juniordev-gitversioning-dependency"')\n";
read -p 'hit enter to continue... ' DONE;
printf "\e[0m";
npm test;