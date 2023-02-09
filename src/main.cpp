#include <iostream>
#include <libfreenect2/frame_listener.hpp>
#include <string>

#include <libfreenect2/frame_listener_impl.h>
#include <libfreenect2/libfreenect2.hpp>
#include <libfreenect2/packet_pipeline.h>
//#include <libfreenect2/logger.h>
//#include <libfreenect2/registration.h>

int main() {
  libfreenect2::Freenect2 freenect2;
  libfreenect2::Freenect2Device *dev = 0;
  libfreenect2::PacketPipeline *pipeline = 0;

  if(freenect2.enumerateDevices() == 0) {
    std::cout << "no device connected!" << std::endl;
    return -1;
  }

  std::string serial = freenect2.getDefaultDeviceSerialNumber();
  std::cout << "serial: " << serial << std::endl;

  pipeline = new libfreenect2::CpuPacketPipeline();
  dev = freenect2.openDevice(serial, pipeline);
  if (!dev) {
    std::cout << "erro ao conectar ao dispositivo" << std::endl;
    return -1;
  }

  // listener
  libfreenect2::SyncMultiFrameListener listener(libfreenect2::Frame::Color | libfreenect2::Frame::Depth | libfreenect2::Frame::Ir);
  libfreenect2::FrameMap frames;

  // start
  dev->start();
  std::cout << "device serial: " << dev->getSerialNumber() << std::endl;
  std::cout << "device firmware: " << dev->getFirmwareVersion() << std::endl;

  return 0;
}
