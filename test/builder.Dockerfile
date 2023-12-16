FROM pimhuisman/hera-builder-base:jammy

ENV HELLO_ORIGIN="builder"
COPY test-hello.sh .

ENTRYPOINT ["/bin/bash", "test-hello.sh"]
