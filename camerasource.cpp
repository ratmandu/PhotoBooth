#include "camerasource.h"

CameraSource::CameraSource(QObject *parent) :
  QObject(parent)
{
  // Create the camera object
  camera = new QCamera(this);

  // Set the capture mode to StillImage
  camera->setCaptureMode(QCamera::CaptureStillImage);

  // Start the camera
  camera->start();
}
