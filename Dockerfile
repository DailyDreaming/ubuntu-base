# A Custom Docker Image mainly as a base for CI/CD in gitlab for UCSC python projects
#
# Based on Adam Novak's quay.io/vgteam/dind fork of Docker-in-Docker in Ubuntu 20.04.
#
# To build this image, run:
#
#   docker login
#   docker build . -t {docker_username}/{tag_key}:{tag_value}
#   docker push {docker_username}/{tag_key}:{tag_value}
#
# For example:
#
#   docker login
#   docker build . -t quay.io/ucsc_cgl/ubuntu-base:latest
#   docker push quay.io/ucsc_cgl/ubuntu-base:latest
#
# Run with:
#
#   docker run -it quay.io/ucsc_cgl/ubuntu-base:latest
FROM quay.io/vgteam/dind
MAINTAINER lblauvel@ucsc.edu

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
        make git build-essential curl zip unzip python3-pip python3-virtualenv \
        python-dev awscli software-properties-common virtualenv && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
        tzdata jq python3.6 python3.6-dev python3.7 python3.7-dev python3.8 python3.8-dev && \
    apt-get clean
