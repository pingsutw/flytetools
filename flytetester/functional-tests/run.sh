#!/bin/bash

set -ex

LATEST_VERSION=$(curl --silent "https://api.github.com/repos/flyteorg/flytesnacks/releases/latest" | jq -r .tag_name)

flytectl register examples -p flytesnacks -d development --config /opt/go/config.yaml

# TODO: remove this env var once structured datasets become the default
FLYTE_SDK_USE_STRUCTURED_DATASET=TRUE flytekit_venv python functional-tests/run-tests.py $LATEST_VERSION P0,P1 functional-tests/functional-test.config core
