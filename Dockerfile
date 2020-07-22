FROM ubuntu:20.04
ENV LANG C.UTF-8

WORKDIR /root
COPY . /root

FROM ubuntu:20.10
ENV LANG C.UTF-8

WORKDIR /root
COPY . /root


FROM fedora:32
ENV LANG C.UTF-8

WORKDIR /root
COPY . /root

FROM fedora:33
ENV LANG C.UTF-8

WORKDIR /root
COPY . /root