
#FROM alpine:3.7
# Alpine's shell is a bb: /bin/sh -> /bin/busybox
#RUN rm /bin/sh
#ADD build/sh /bin/sh
#ADD build/jsh /bin/jsh
#ENTRYPOINT ["sh"]

# That simply says 'no space'. Next.

ARG base_tag=9-slim
FROM debian:$base_tag
# Debian comes with bash/rbash, sh/dash, and chsh
#RUN ls -la /bin/*sh /usr/bin/*sh /usr/local/bin/*sh
ADD build/sh /usr/bin/sh
ADD build/jsh /usr/bin/jsh
ENTRYPOINT ["/usr/bin/sh"]
