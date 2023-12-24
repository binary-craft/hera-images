# Base image
FROM ubuntu:jammy AS hera-base

LABEL io.buildpacks.stack.id="net.binarycraft.stacks.hera"
ENV CNB_STACK_ID="net.binarycraft.stacks.hera"

# Set default entrypoint (will be overriden in case of buildpack)
ENTRYPOINT ["/bin/bash"]


# Runner image
FROM hera-base as hera-runner-base

ARG cnb_gid=1000
ARG cnb_uid=1002

# Create group and user
RUN groupadd -g ${cnb_gid} cnb
RUN useradd -rms /bin/bash -u ${cnb_uid} -g ${cnb_gid} hera

# Set user
USER ${cnb_uid}:${cnb_gid}


# Builder image
FROM hera-base AS hera-builder-base

ARG apt_get_build_dependencies="clang make"
ARG apt_get_parameters="-y --no-install-recommends"
ARG apt_get_system_dependencies="curl git jq python3 pipx unzip zip"
ARG cnb_gid=1000
ARG cnb_uid=1001
ARG pip_requirements_file="requirements.txt"

# Install apt-get dependencies
RUN apt-get update ${apt_get_parameters}
RUN apt-get install ${apt_get_parameters} ${apt_get_system_dependencies} ${apt_get_build_dependencies}

# Create group and user
ENV CNB_GROUP_ID=${cnb_gid}
ENV CNB_USER_ID=${cnb_uid}
RUN groupadd -g ${cnb_gid} cnb
RUN useradd -rms /bin/bash -u ${CNB_USER_ID} -g ${CNB_GROUP_ID} hera

# Set user and path
USER ${CNB_USER_ID}:${CNB_GROUP_ID}
ENV PATH "/home/hera/.local/bin:${PATH}"
WORKDIR /home/hera

# Install pip dependencies
COPY $pip_requirements_file .
RUN xargs -I % pipx install "%" < requirements.txt

# Install VCPKG
RUN git clone --depth 1 https://github.com/Microsoft/vcpkg.git .local/vcpkg
ENV VCPKG_FORCE_SYSTEM_BINARIES=1
RUN .local/vcpkg/bootstrap-vcpkg.sh --disableMetrics
RUN ln -s ~/.local/vcpkg/vcpkg ~/.local/bin/vcpkg

# Detect Conan profile
RUN conan profile detect
