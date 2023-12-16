FROM pimhuisman/hera-runner-base:jammy

ENV HELLO_ORIGIN="runner"
COPY test-hello.sh .

ENTRYPOINT ["/bin/bash", "test-hello.sh"]
