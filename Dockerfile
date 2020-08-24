FROM shellcheck:v0.7.1 as bash_linter

WORKDIR /root
COPY . /root
RUN shellcheck -x ~/setup.sh ~/.profile ~/.logout ~/.envrc ~/bin/*.sh

FROM ubuntu:20.04

WORKDIR /root
COPY . /root
RUN /root/setup.sh

FROM ubuntu:20.10

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

FROM alpine:3.12.0

WORKDIR /root
COPY . /root
RUN /root/setup.sh
