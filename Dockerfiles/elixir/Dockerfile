# consup_elixir
# Consup elixir image
# See https://github.com/LeKovr/consup
#

FROM lekovr/consup_baseapp

MAINTAINER Alexey Kovrizhkin <lekovr+docker@gmail.com>

ENV DOCKERFILE_VERSION  161121

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# -------------------------------------------------------------------------------
# Run custom setup scripts

RUN apt-get update && apt-get install -y libwxbase3.0-0 libwxgtk3.0-0 libsctp1 \
  && wget https://packages.erlang-solutions.com/erlang/esl-erlang/FLAVOUR_1_general/esl-erlang_19.1.5-1~debian~jessie_amd64.deb \
  && dpkg -i esl-erlang_19.1.5-1~debian~jessie_amd64.deb \
  && rm esl-erlang_19.1.5-1~debian~jessie_amd64.deb \
  && wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb \
  && rm erlang-solutions_1.0_all.deb \
  && apt-get update \
  && apt-get install elixir

# -------------------------------------------------------------------------------
# Get local deps

COPY mix.exs /root/mix.exs
RUN cd /root \
  && mix do local.hex --force, deps.get

# ------------------------------------------------------------

WORKDIR /home/app

