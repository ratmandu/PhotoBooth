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

  connect(capture, SIGNAL(imageSaved(int,QString)), this, SLOT(pictureSaved(int, QString)));
}

CameraSource::~CameraSource()
{
  camera->stop();
  camera->deleteLater();
}

void CameraSource::takePicture(int pictureNumber)
{
  if (capture->isReadyForCapture()) {
    saveLocation = QStandardPaths::writableLocation(QStandardPaths::PicturesLocation);
    saveLocation.append("/").append(QDateTime::currentDateTime().toString(Qt::TextDate)).append(".jpg");
    capture->capture(saveLocation);
    qDebug() << saveLocation;
    takenPictures[pictureNumber] = new QImage(saveLocation);
  }
}

void CameraSource::pictureSaved(int id, QString imageLocation) {
  emit pictureCaptured(imageLocation);
}

