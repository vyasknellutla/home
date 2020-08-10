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