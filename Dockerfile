FROM debian:latest

WORKDIR /build

# Install required system packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install \
  #libusb-dev \
  build-essential \
  cmake \
  git \
  libusb-1.0 \
  python3-numpy

# create user non root
ARG UID=1000
ARG GID=1000

RUN groupadd -g "${GID}" user_name \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" user_name

USER user_name
