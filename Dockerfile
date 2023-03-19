FROM archlinux:latest

WORKDIR /build

# Install required system packages
RUN yes | pacman -Sy --needed \
  base-devel \
  cmake \
  git \
  libjpeg-turbo \
  libusb \
  libva \
  libva \
  ninja

# create user non root
ARG UID=1000
ARG GID=1000

RUN groupadd -g "${GID}" user_name \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" user_name

USER user_name
