#include "camerasource.h"

CameraSource::CameraSource(QObject *parent) :
  QObject(parent)
{
  camera = new QCamera(this);

  camera->setCaptureMode(QCamera::CaptureStillImage);
  camera->start();
}
