# Hera CNB images for native (C and C++)
[![Build and push](https://github.com/pim-huisman/hera-images/actions/workflows/build-and-push.yml/badge.svg)](https://github.com/pim-huisman/hera-images/actions/workflows/build-and-push.yml) 
[![Snyk scan](https://github.com/pim-huisman/hera-images/actions/workflows/snyk-scan.yml/badge.svg)](https://github.com/pim-huisman/hera-images/actions/workflows/snyk-scan.yml) 
[![Auto update on Ubuntu release](https://github.com/pim-huisman/hera-images/actions/workflows/auto-update.yml/badge.svg)](https://github.com/pim-huisman/hera-images/actions/workflows/auto-update.yml)

## About
This project is used to build Cloud Native Buildpack ready images for native applications such as C and C++.

| Property         | Value        |
|------------------|--------------|
| Operating system | Linux        |
| Distribution     | Ubuntu       |
| Architecture     | amd64, arm64 |


## Using the images
The published images will be made available on Docker hub. This project contains the source and is used to build the images.

### Builder image
See [Docker hub](https://hub.docker.com/r/pimhuisman/hera-builder).

```docker pull pimhuisman/hera-builder:jammy```

### Runner image
See [Docker hub](https://hub.docker.com/r/pimhuisman/hera-runner).

```docker pull pimhuisman/hera-runner:jammy```

## Building the images
There are three stages within the Dockerfile:
- **hera-base** - common base stage for the builder and runner, not used directly
- **hera-builder** - stage to create the builder image
- **hera-runner** - stage to create the runner image

For example, to build `hera-runner` the following command can be issued:

```docker build --target hera-runner -t myrepo/hera-runner:mytag .```

### Arguments to pass to Docker
Both relevant stages have some arguments that can be passed to customise the build.

#### Builder arguments

| Argument              | Description                          | Default value                |
|-----------------------|--------------------------------------|------------------------------|
| apt_get_dependencies  | Dependencies to install with apt-get | `clang jq make python3 pipx` |
| apt_get_parameters    | Parameters to pass to apt-get        | `-y --no-install-recommends` |
| cnb_uid               | CNB user ID                          | 1001                         |
| cnb_gid               | CNB group ID                         | 1000                         |
| pip_requirements_file | Python requirements file             | requirements.txt             |

#### Runner arguments

| Argument              | Description                          | Default value                |
|-----------------------|--------------------------------------|------------------------------|
| cnb_uid               | CNB user ID                          | 1002                         |
| cnb_gid               | CNB group ID                         | 1000                         |

## Contributing
This project is open for any contributions that you might have. Bugfixes and feature enhancements are very welcome.

If you'd like to implement a major new feature or change some fundamentals of the project please send me a DM to discuss.

## License
This project is licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE) for the full license text.