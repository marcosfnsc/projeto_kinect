FROM archlinux:latest

WORKDIR /build

# Install required system packages
RUN pacman -Sy --needed --noconfirm \
  base-devel \
  cmake \
  curl \
  doxygen \
  freeglut \
  git \
  glfw-x11 \
  glu \
  java-environment \
  libjpeg-turbo \
  libusb \
  libva \
  ninja

# create user non root
ARG UID=1000
ARG GID=1000

RUN groupadd -g "${GID}" user_name \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" user_name

USER user_name
