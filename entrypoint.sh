#!/usr/bin/env bash

set -euo pipefail

/bin/_install "$1"

/bin/_typecheck
/bin/_lint
