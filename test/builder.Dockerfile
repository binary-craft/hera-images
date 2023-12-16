FROM hera-builder-base:testing

ENV HELLO_ORIGIN="builder"
COPY test-hello.sh .

# Check if all the necessary builder software is installed.
RUN clang --version && \
    cmake --version && \
    conan --version && \
    make --version && \
    meson --version && \
    ninja --version

ENTRYPOINT ["/bin/bash", "test-hello.sh"]
