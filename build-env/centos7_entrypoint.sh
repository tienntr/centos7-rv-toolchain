#!/bin/bash

source scl_source enable devtoolset-11 rh-python38

set -eu
exec "$@"
