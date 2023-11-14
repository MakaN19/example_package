#!/usr/bin/env bash
rm *.whl
DOCKER_BUILDKIT=1 docker build -t custom_connectors -f \
      custom_connectors/Dockerfile_build --output . custom_connectors

wheel=$(ls | grep *.whl)
echo "Found library version: $wheel"
aws s3 cp $wheel "s3://simple-python-package/simple_connectors/$wheel"

exit_code=$?
echo "#### exit code $exit_code"
