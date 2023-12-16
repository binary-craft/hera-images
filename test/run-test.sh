#!/usr/bin/env bash
set -eo pipefail

docker build -f builder.Dockerfile -t test-builder .
builder_output=$(docker run test-builder)

if [[ "${builder_output}" == "Hello, builder!" ]]; then
  echo "Successfully completed the testing for builder"
else
  echo "Test failed: the builder command output was not as expected: ${builder_output}"
  exit 1
fi

docker build -f runner.Dockerfile -t test-runner .
runner_output=$(docker run test-runner)

if [[ "${runner_output}" == "Hello, runner!" ]]; then
  echo "Successfully completed the testing for runner"
else
  echo "Test failed: the runner command output was not as expected: ${runner_output}"
  exit 2
fi
