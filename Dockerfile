FROM debian:latest

WORKDIR /build

# Install required system packages
RUN apt-get update && apt-get -y install \
  #libusb-dev \
  build-essential \
  cmake \
  cython3 \
  freeglut3-dev \
  git \
  libjpeg-turbo-progs \
  libjpeg62-turbo \
  libjpeg62-turbo-dev \
  libusb-1.0 \
  libva-dev \
  libva-drm2 \
  libva2 \
  pkg-config \
  python3-dev \
  python3-numpy


# create user non root
ARG UID=1000
ARG GID=1000

RUN groupadd -g "${GID}" user_name \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" user_name

USER user_name
