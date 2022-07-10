#!/bin/bash
cd ..
for f in gcroot/materializers/*; do echo "$(basename $f) - $($f/calculateSha)"; $f/generateMaterialized materialized/$(basename $f); done