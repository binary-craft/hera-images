FROM hera-runner-base:testing

ENV HELLO_ORIGIN="runner"
COPY test-hello.sh .

# Make sure that no builder software is installed.
RUN ! command -v clang >/dev/null 2>&1 || { exit 1; }
RUN ! command -v cmake >/dev/null 2>&1 || { exit 1; }
RUN ! command -v conan >/dev/null 2>&1 || { exit 1; }
RUN ! command -v make >/dev/null 2>&1 || { exit 1; }
RUN ! command -v meson >/dev/null 2>&1 || { exit 1; }
RUN ! command -v ninja >/dev/null 2>&1 || { exit 1; }

ENTRYPOINT ["/bin/bash", "test-hello.sh"]
