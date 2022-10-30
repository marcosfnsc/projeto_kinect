FROM debian:latest

WORKDIR /build

# Install required system packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install \
  #libusb-dev \
  cmake \
  git \
  libusb-1.0 \
  python3-numpy
