#include "camerasource.h"

CameraSource::CameraSource(QObject *parent) :
  QObject(parent)
{
  // Create the camera object
  camera = new QCamera(this);

  // create the capture object, this takes the pictures
  capture = new QCameraImageCapture(camera, this);

  // Set the capture mode to StillImage
  camera->setCaptureMode(QCamera::CaptureStillImage);

  // Start the camera
  camera->start();
}

CameraSource::~CameraSource()
{
  camera->stop();
  camera->deleteLater();
}

void CameraSource::takePicture(int pictureNumber)
{
  if (capture->isReadyForCapture()) {
    QString saveLocation = "./Images/SingleImages/";
    saveLocation.append(QDateTime::currentDateTime().toString(Qt::TextDate)).append(".jpg");
    capture->capture(saveLocation);
    takenPictures[pictureNumber] = new QImage(saveLocation);

    emit pictureCaptured(saveLocation);
  }
}
