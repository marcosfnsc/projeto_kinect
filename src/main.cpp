#include <iostream>
#include <string>

#include <libfreenect2/frame_listener_impl.h>
#include <libfreenect2/libfreenect2.hpp>
#include <libfreenect2/packet_pipeline.h>
//#include <libfreenect2/logger.h>
//#include <libfreenect2/registration.h>

int main () {
  libfreenect2::Freenect2 freenect2;
  libfreenect2::Freenect2Device *dev = 0;
  libfreenect2::PacketPipeline *pipeline = 0;

  if(freenect2.enumerateDevices() == 0) {
    std::cout << "no device connected!" << std::endl;
    return -1;
  }
  std::string serial;
  if (serial == "") {
    serial = freenect2.getDefaultDeviceSerialNumber();
  }

  pipeline = new libfreenect2::CpuPacketPipeline();
  dev = freenect2.openDevice(serial, pipeline);
  std::cout << dev->getSerialNumber() << std::endl;

  return 0;
}
