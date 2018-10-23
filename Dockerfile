
#FROM alpine:3.7
# Alpine's shell is a bb-sh; comes with /bin/{sh,ash} -> /bin/busybox
#
#RUN rm /bin/sh
#ADD build/sh /bin/sh
#ADD build/jsh /bin/jsh
#ENTRYPOINT ["sh"]

# That simply says 'no space'. Next.

ARG base_tag=9-slim
FROM debian:$base_tag

# Debian comes with bash/rbash, sh/dash
#RUN ls -la /bin/*sh /usr/bin/*sh /usr/local/bin/*sh
RUN apt-get update && apt-get install -qyy ksh zsh posh

ADD build/sh /usr/bin/sh
ADD build/jsh /usr/bin/jsh

# NOTE: exec should pick up /usr/bin/ now
ENTRYPOINT ["sh"]
