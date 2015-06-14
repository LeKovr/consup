# consup_base
# Consul Supervisor based image
#

FROM debian:wheezy

ENV DOCKERFILE_VERSION_BASE  150130

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# -------------------------------------------------------------------------------
# Setup base packages and supervisor

RUN apt-get update && apt-get install -y wget curl sudo mc python-setuptools \
  && easy_install supervisor \
  && groupadd supervisor \
  && mkdir -p /var/run/supervisor \
  && echo "alias svd=\"supervisorctl -c /etc/supervisor/supervisord.conf\"" >> /root/.bashrc

ENV TERM xterm

COPY supervisord.conf /etc/supervisor/

VOLUME ["/var/run/supervisor", "/var/log/supervisor"]

# -------------------------------------------------------------------------------
# Run custom setup scripts

COPY setup_*.sh /opt/
RUN for f in /opt/setup_*.sh ; do . $f ; done && rm /opt/setup_*.sh

# -------------------------------------------------------------------------------
# Setup primary lang

ENV LANG en_US.UTF-8
#? RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

# -------------------------------------------------------------------------------
# Run init.d.sh on boot before supervisor

COPY init.d /init.d
COPY init.d.sh /
CMD ["/init.d.sh", "supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n" ]

# Default timezone
ENV TZ="Europe/Moscow"
