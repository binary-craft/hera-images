# Hera CNB images for native (C and C++)
[![Build and push](https://github.com/binary-craft/hera-images/actions/workflows/build-and-push.yml/badge.svg)](https://github.com/binary-craft/hera-images/actions/workflows/build-and-push.yml) 
[![Check for Ubuntu updates](https://github.com/binary-craft/hera-images/actions/workflows/check-ubuntu-updates.yml/badge.svg)](https://github.com/binary-craft/hera-images/actions/workflows/check-ubuntu-updates.yml) 
[![Snyk scan](https://github.com/binary-craft/hera-images/actions/workflows/snyk-scan.yml/badge.svg)](https://github.com/binary-craft/hera-images/actions/workflows/snyk-scan.yml)

## About
This project is used to build Cloud Native Buildpack ready images for native applications written in C and C++.

With the builder image you can use your favourite builder and packaging software such as CMake, Conan, Make, Meson and Ninja to build your software. The runner image is the perfect 'lean and mean' counterpart for the builder image at runtime, but can also be used for standalone projects.

| Property         | Value                                                                                                                                                               |
|------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Operating system | Linux                                                                                                                                                               |
| Distribution     | [Ubuntu](https://ubuntu.com)                                                                                                                                        |
| Version          | 22 LTS (Jammy Jellyfish)                                                                                                                                            |
| Architecture     | amd64, arm64                                                                                                                                                        |
| Compiler         | [Clang](https://clang.llvm.org) (default), [GCC](https://gcc.gnu.org) (optional)                                                                                    |
| Builder software | [CMake](https://cmake.org), [Conan](https://conan.io), [Make](https://www.gnu.org/software/make), [Meson](https://mesonbuild.com), [Ninja](https://ninja-build.org) |


## Using the images
The published images will be made available on Docker hub. This project contains the source and is used to build the images.

### Builder image
See [Docker hub](https://hub.docker.com/r/bincraft/hera-builder-base).

```docker pull bincraft/hera-builder-base:jammy```

### Runner image
See [Docker hub](https://hub.docker.com/r/bincraft/hera-runner-base).

```docker pull bincraft/hera-runner-base:jammy```

## Building the images
There are three stages within the Dockerfile:
- **hera-base** - common base stage for the builder and runner, not used directly
- **hera-builder-base** - stage to create the base builder image
- **hera-runner-base** - stage to create the base runner image

For example, to build `hera-runner-base` the following command can be issued:

```docker build --target hera-runner-base -t myrepo/hera-runner-base:mytag .```

### Arguments to pass to Docker
Both relevant stages have some arguments that can be passed to customise the build.

#### Builder arguments

| Argument                    | Description                             | Default value                |
|-----------------------------|-----------------------------------------|------------------------------|
| apt_get_build_dependencies  | Build dependencies to install with APT  | `clang make`                 |
| apt_get_parameters          | Parameters to pass to APT               | `-y --no-install-recommends` |
| apt_get_system_dependencies | System dependencies to install with APT | `jq python3 pipx`            |
| cnb_gid                     | CNB group ID                            | 1000                         |
| cnb_uid                     | CNB user ID                             | 1001                         |
| pip_requirements_file       | Python requirements file                | requirements.txt             |

The builder software that is not installed using APT will be installed using [pipx](https://pipx.pypa.io), this can be customised with an alternative `requirements.txt` file.

#### Runner arguments

| Argument                    | Description                              | Default value               |
|-----------------------------|------------------------------------------|-----------------------------|
| cnb_gid                     | CNB group ID                             | 1000                        |
| cnb_uid                     | CNB user ID                              | 1002                        |

### Compiler choice
By default, Clang is chosen as compiler. It is very straightforward to use GCC instead, set `build-essential` instead of `clang` in the `apt_get_build_dependencies` argument to the builder.
Also see [Apple Open Source](https://opensource.apple.com/source/clang/clang-23/clang/tools/clang/www/comparison.html#gcc) for a comparison of GCC and Clang.

## Maintaining
This project is aimed to have a straightforward maintenance by using all relevant automation that we can. Automation is used for:
- Building and pushing the images on any relevant changes to the `main` branch.
- Checking for upstream Ubuntu LTS updates and automatically integrating them.
- Snyk vulnerability scanning.

### Dependency versions
#### Ubuntu LTS
Within the same LTS version there is an automation in place to automatically upgrade to the latest patch and/or minor version. 
If a new Ubuntu LTS (with a major version change) is published this is considered a breaking change, such releases will get their own tags in line with Ubuntu Docker image tagging strategy.

#### APT packages
APT packages will be automatically updated on rebuild to their latest versions suitable for the Ubuntu LTS release in use.

#### CMake, Conan, Meson, Ninja
Pinning is done on major versions. Any patch and/or minor updates will be automatically applied on rebuild.

## Contributing
This project is open for any contributions that you might have. Bugfixes and feature enhancements are very welcome.

If you'd like to implement a major new feature or change some fundamentals of the project please send me a DM to discuss.

## License
This project is licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE) for the full license text.