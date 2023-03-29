FROM archlinux:latest

WORKDIR /build

# Install required system packages
RUN yes | pacman -Sy --needed \
  base-devel \
  cmake \
  doxygen \
  freeglut \
  git \
  glfw-x11 \
  glu \
  jdk8-openjdk \
  libjpeg-turbo \
  libusb \
  libva \
  ninja \
  systemd-libs

# create user non root
ARG UID=1000
ARG GID=1000

RUN groupadd -g "${GID}" user_name \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" user_name

USER user_name
