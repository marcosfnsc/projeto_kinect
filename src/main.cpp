#include <iostream>
#include <string>

#include <libfreenect2/frame_listener.hpp>
#include <libfreenect2/frame_listener_impl.h>
#include <libfreenect2/libfreenect2.hpp>
#include <libfreenect2/logger.h>
#include <libfreenect2/packet_pipeline.h>
#include <libfreenect2/registration.h>

#include <opencv2/opencv.hpp>

int main() {
  libfreenect2::Freenect2 freenect2;
  libfreenect2::Freenect2Device *dev = 0;
  libfreenect2::PacketPipeline *pipeline = 0;

  if (freenect2.enumerateDevices() == 0) {
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
  libfreenect2::SyncMultiFrameListener listener(libfreenect2::Frame::Color |
                                                libfreenect2::Frame::Depth |
                                                libfreenect2::Frame::Ir);
  libfreenect2::FrameMap frames;
  dev->setColorFrameListener(&listener);
  dev->setIrAndDepthFrameListener(&listener);


  // start
  dev->start();
  std::cout << "device serial: " << dev->getSerialNumber() << std::endl;
  std::cout << "device firmware: " << dev->getFirmwareVersion() << std::endl;

  // registration
  libfreenect2::Registration *registration = new libfreenect2::Registration(dev->getIrCameraParams(), dev->getColorCameraParams());
  libfreenect2::Frame undistorted(512, 424, 4), registered(512, 424, 4), detpth2(1920, 1080 +2, 4);

  bool loop_status = true;
  cv::Mat rgb_mat, ir_mat, depth_mat;
  cv::Mat rgb_d, rgb_d2;
  cv::Mat depth_mat_undistorted;
  while (loop_status) {
    listener.waitForNewFrame(frames);
    libfreenect2::Frame *rgb   = frames[libfreenect2::Frame::Color];
    libfreenect2::Frame *ir    = frames[libfreenect2::Frame::Ir];
    libfreenect2::Frame *depth = frames[libfreenect2::Frame::Depth];

    cv::Mat(rgb->height, rgb->width, CV_8UC4, rgb->data).copyTo(rgb_mat);
    cv::Mat(ir->height, ir->width, CV_32FC1, ir->data).copyTo(ir_mat);
    cv::Mat(depth->height, depth->width, CV_32FC1, depth->data).copyTo(depth_mat);

    cv::imshow("rgb", rgb_mat);
    cv::imshow("ir", ir_mat / 4096.0f);
    cv::imshow("depth", depth_mat / 4096.0f);

    registration->apply(rgb, depth, &undistorted, &registered, true, &detpth2);

    cv::Mat(undistorted.height, undistorted.width, CV_32FC1, undistorted.data).copyTo(depth_mat_undistorted);
    cv::Mat(registered.height, registered.width, CV_8UC4, registered.data).copyTo(rgb_d);
    cv::Mat(detpth2.height, detpth2.width, CV_32FC1, detpth2.data).copyTo(rgb_d2);

    cv::imshow("undistorted", depth_mat_undistorted / 4096.0f);
    cv::imshow("registered", rgb_d);
    cv::imshow("depth2RGB", rgb_d2 / 4096.0f);

    int key = cv::waitKey(1);
    loop_status = loop_status || (key > 0 && ((key & 0xFF) == 27));

    listener.release(frames);
  }


  // stop
  dev->stop();
  dev->close();

  return 0;
}
