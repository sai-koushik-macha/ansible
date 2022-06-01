FROM ubuntu:jammy AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt upgrade -y
RUN apt install -y software-properties-common
RUN apt install -y curl
RUN apt install -y git
RUN apt install -y build-essential
RUN apt-add-repository -y ppa:ansible/ansible
RUN apt update
RUN apt install -y ansible
RUN apt clean autoclean
RUN apt autoremove --yes

FROM base AS root
ARG TAGS
USER root
WORKDIR /root/ansible

FROM root
COPY . .
CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]
