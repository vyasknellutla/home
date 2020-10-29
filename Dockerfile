FROM koalaman/shellcheck:v0.7.1 as bash_linter

WORKDIR /root
COPY . /root
RUN shellcheck -x ~/setup.sh ~/.profile ~/.logout ~/.envrc ~/bin/*.sh

# Ubuntu 20.04
FROM ubuntu:focal-20201008

WORKDIR /root
COPY . /root
RUN /root/setup.sh

# Ubuntu 20.10
FROM ubuntu:focal-20201008

WORKDIR /root
COPY . /root
RUN /root/setup.sh

FROM fedora:32

WORKDIR /root
COPY . /root
RUN /root/setup.sh

FROM fedora:33

WORKDIR /root
COPY . /root
RUN /root/setup.sh

FROM centos:8.2.2004

WORKDIR /root
COPY . /root
RUN /root/setup.sh

FROM alpine:3.12.1

WORKDIR /root
COPY . /root
RUN /root/setup.sh
