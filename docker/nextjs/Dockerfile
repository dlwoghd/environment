FROM ubuntu:22.04
LABEL maintainer="Jason Lee <merryljh91@naver.com>"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
ENV INSTALL_PATH /opt/services

RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

RUN apt update \
  && apt install -qq -y init systemd \
  && apt install -qq -y build-essential libcairo2 libcairo2-dev\
  && apt install -qq -y tzdata \
  && apt install -qq -y vim curl \
  && apt install -qq -y nginx \
  && apt install -qq -y python3.10 pip\
  && apt install -qq -y gcc g++ make\
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/{apt,dpkg,cache,log}

RUN curl -sL https://deb.nodesource.com/setup_16.x | /bin/bash - \
  && apt install -qq -y nodejs


RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

RUN echo "alias python=python3.10" >> /root/.bashrc
ADD start.sh ./
RUN chmod 700 start.sh

COPY ./local.nginx.setting /etc/nginx/sites-available/
RUN rm -rf /etc/nginx/sites-enabled/default
RUN /bin/bash -c "ln -s /etc/nginx/sites-available/local.nginx.setting /etc/nginx/sites-enabled/local.nginx.setting"