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
    qDebug() << saveLocation << pictureNumber;
    lastPictureNumber = pictureNumber;
  }
}

void CameraSource::generateStrip(int numberOfPictures)
{
  qDebug() << takenPictures[0]->size();
  QPixmap finalStrip(takenPictures[0]->width() + 10, (takenPictures[0]->height() * numberOfPictures) + (10 * numberOfPictures) + 5);
  finalStrip.fill();

  QPainter *p = new QPainter();

  p->begin(&finalStrip);

  for (int i = 0; i < numberOfPictures; i++) {
    p->drawImage(5, (takenPictures[i]->height() * i) + (10 * (i + 1)), * takenPictures[(numberOfPictures - 1) - i]);
  }

  p->end();

  delete p;

  QString finalStripLocation = QStandardPaths::writableLocation(QStandardPaths::PicturesLocation);
  finalStripLocation.append("/Final - ");
  finalStripLocation.append(QDateTime::currentDateTime().toString(Qt::TextDate)).append(".jpg");
  finalStrip.save(finalStripLocation);

  emit stripGenerated(finalStripLocation);
}

void CameraSource::pictureSaved(int id, QString imageLocation) {
  takenPictures[lastPictureNumber - 1] = new QImage(imageLocation);
  emit pictureCaptured(imageLocation);
}

