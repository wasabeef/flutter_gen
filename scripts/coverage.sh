#!/usr/bin/env bash

set -o pipefail

DIR="${1}"
cd ${DIR}
dart pub global activate coverage
dart test --coverage="coverage"
format_coverage --lcov --in=coverage --out=coverage.lcov --packages=.packages --report-on=lib
