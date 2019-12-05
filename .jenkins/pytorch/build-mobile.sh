#!/usr/bin/env bash
# DO NOT ADD 'set -x' not to reveal CircleCI secret context environment variables
set -eu -o pipefail

# This script uses linux host toolchain + mobile build options in order to
# build & test mobile libtorch without having to setup Android/iOS
# toolchain/simulator.

COMPACT_JOB_NAME="${BUILD_ENVIRONMENT}"

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

echo "Clang version:"
clang --version

# Build libtorch library with mobile build options
scripts/build_mobile.sh -DBUILD_BINARY=ON "$@"

# Build client project using libraries/headers/cmake generated by previous step
# in "build_mobile/install".
test/mobile/op_deps/build.sh