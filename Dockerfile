FROM ubuntu:20.04
ENV LANG C.UTF-8

WORKDIR /root
COPY . /root
RUN /root/setup.sh

FROM ubuntu:20.10
ENV LANG C.UTF-8

WORKDIR /root
COPY . /root
RUN /root/setup.sh

FROM fedora:32
ENV LANG C.UTF-8

WORKDIR /root
COPY . /root
RUN /root/setup.sh

FROM fedora:33
ENV LANG C.UTF-8

WORKDIR /root
COPY . /root
RUN /root/setup.sh