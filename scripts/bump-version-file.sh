#!/bin/sh
CURR_DIR="$(dirname $0)";
VERSION_FILE_PATH="${PWD}/${CURR_DIR}/../.version";

_=$(stat ${VERSION_FILE_PATH} &>/dev/null);

if [ "$?" != "0" ]; then
  printf -- "(n/a) -> 0.0.0 (initialised)\n";
  printf -- '0.0.0' > ${VERSION_FILE_PATH};
else
  VERSION="$(cat ${VERSION_FILE_PATH})";
  MAJOR=$(printf -- "${VERSION}" | cut -f 1 -d '.');
  MINOR=$(printf -- "${VERSION}" | cut -f 2 -d '.');
  PATCH=$(printf -- "${VERSION}" | cut -f 3 -d '.');
  if [ "$1" = "major" ]; then
    MAJOR=$((MAJOR+1));
    MINOR=0;
    PATCH=0;
  elif [ "$1" = "minor" ]; then
    MINOR=$((MINOR+1));
    PATCH=0;
  else
    PATCH=$((PATCH+1));
  fi;
  printf -- "${VERSION} -> ${MAJOR}.${MINOR}.${PATCH}\n";
  printf -- "${MAJOR}.${MINOR}.${PATCH}" > ${VERSION_FILE_PATH};
fi;
