# use base image.
FROM sloopstash/amazonlinux:v1

# switch work directory.
WORKDIR /tmp

# create user named kibana.
RUN set -x \
  && useradd -m -s /bin/bash -d /usr/local/lib/kibana kibana

# install kibana.
COPY kibana-6.8.2-linux-x86_64.tar.gz ./
RUN set -x \
  && sha1sum kibana-6.8.2-linux-x86_64.tar.gz \
  && tar xvzf kibana-6.8.2-linux-x86_64.tar.gz > /dev/null \
  && cp -r kibana-6.8.2-linux-x86_64/* /usr/local/lib/kibana/ \
  && chown -R kibana:kibana /usr/local/lib/kibana \
  && rm -rf kibana-6.8.2-linux-x86_64.tar.gz kibana-6.8.2-linux-x86_64
RUN set -x \
  && mkdir /opt/kibana \
  && mkdir /opt/kibana/data \
  && mkdir /opt/kibana/log \
  && touch /opt/kibana/log/stdout.log \
  && mkdir /opt/kibana/system \
  && touch /opt/kibana/system/process.pid \
  && chown -R kibana:kibana /opt/kibana

# switch work directory.
WORKDIR /
