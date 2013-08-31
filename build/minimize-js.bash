#!/bin/bash

pushd `dirname $0` > /dev/null
cd ..

echo 'Running Jcrop minimization script'

export JCROP_VERSION=${JCROP_VERSION-`cat build/VERSION`}
export JCROP_BUILD=${JCROP_BUILD-`date +"%Y%m%d"`}

OUTFILE=Jcrop.min.js
MYBUILD="${JCROP_VERSION} (build:${JCROP_BUILD})"

cat build/LICENSE | sed \
  -e "s/__BUILD__/${MYBUILD}/" \
  -e "s/__OUTFILE__/${OUTFILE}/" \
  > js/${OUTFILE}

git show :js/Jcrop.js | uglifyjs --max-line-len 1024 -nc >> js/${OUTFILE}

popd > /dev/null

