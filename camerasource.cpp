/*
  Copyright (C) 2014 - Justin Richards

  This file is part of Photobooth.

  Photobooth is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  Photobooth is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Photobooth.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "camerasource.h"

// Constructor for the class
CameraSource::CameraSource(QObject *parent) :
  QObject(parent)
{
  // Create the camera object
  camera = new QCamera(QCamera::FrontFace);

  // create the capture object, this takes the pictures
  capture = new QCameraImageCapture(camera, this);

  // Create the recorder object, this takes the videos
  recorder = new QMediaRecorder(camera, this);

  QVideoEncoderSettings settings = recorder->videoSettings();

  settings.setResolution(1280, 720);
  settings.setQuality(QMultimedia::VeryHighQuality);
  settings.setFrameRate(30);

  recorder->setVideoSettings(settings);
  recorder->setContainerFormat("mp4");

  // Start the camera
//  camera->start();

  // Connects the imageSaved signal, to the pictureSaved slot
  // basically alerts the application that the picture has been
  // saved and can be loaded and displayed by the QML code
  connect(capture, SIGNAL(imageSaved(int,QString)), this, SLOT(pictureSaved(int, QString)));
}

// Destructor, gets called when the class is destroyed
CameraSource::~CameraSource()
{
  // Stop the camera
  camera->stop();

  // delete the capture object
  capture->deleteLater();

  // delete the camera object
  camera->deleteLater();
}

// Takes a picture, and saves the image
void CameraSource::takePicture(int pictureNumber)
{
  // Set the capture mode to StillImage
  camera->setCaptureMode(QCamera::CaptureStillImage);

  // make sure the capture object is ready to capture an image
  if (capture->isReadyForCapture()) {
    // We need to find the proper place to save the pictures
    saveLocation = QStandardPaths::writableLocation(QStandardPaths::PicturesLocation);

    // we append the current date and time, as well as a file extension
    saveLocation.append("/Photobooth/SinglePics/").append(QDateTime::currentDateTime().toString(Qt::TextDate)).append(".jpg");

    // tell the capture object to actually capture a picture
    capture->capture(saveLocation);

    // save the last picture number, for future reference when we
    // save the picture in ram for the final strip generation
    lastPictureNumber = pictureNumber;
  }
}

void CameraSource::startVideo()
{
  camera->setCaptureMode(QCamera::CaptureVideo);

  saveLocation = QStandardPaths::writableLocation(QStandardPaths::PicturesLocation);

  saveLocation.append("/Photobooth/Videos/").append(QDateTime::currentDateTime().toString(Qt::TextDate)).append(".mp4");

  recorder->record();
}

void CameraSource::stopVideo()
{
  recorder->stop();
//  camera->stop();
//  camera->start();
}

// Generates the final image strip, saves it, and sends the file path
// off to the QML code to be displayed
void CameraSource::generateStrip(int numberOfPictures)
{
  // Create our QPixmap which will hold the finalStrip
  // needs to be the right size for the number of pictures
  // we have taken, plus a border to make it pretty
  QPixmap finalStrip(takenPictures[0]->width() + 10, (takenPictures[0]->height() * numberOfPictures) + (10 * numberOfPictures) + 5);

  // fill the blank image with white
  finalStrip.fill();

  // create a painter
  QPainter *p = new QPainter();

  // start the painter, setting the QPixmap as our drawing device
  p->begin(&finalStrip);

  // draw the pictures on the final strip, leaving a gap between them, and a border around the whole image
  for (int i = 0; i < numberOfPictures; i++) {
    p->drawImage(5, (takenPictures[i]->height() * i) + (10 * (i + 1)), * takenPictures[(numberOfPictures - 1) - i]);
  }

  // stop the painter
  p->end();

  // free up the memory the painter was using
  delete p;

  // This finds the platform specific default picture location
  // ~/Pictures on OSX and Linux
  // C:\Documents And Settings\<USERNAME>\Pictures on Windows
  // Have not tested for Android, iOS, Blackberry, etc yet
  QString finalStripLocation = QStandardPaths::writableLocation(QStandardPaths::PicturesLocation);

  // Add the folder where they will be saved
  finalStripLocation.append("/Photobooth/Final/");

  // and append the current date and time, plus a file extension
  finalStripLocation.append(QDateTime::currentDateTime().toString(Qt::TextDate)).append(".jpg");

  // set up a QFile to save the image to
  QFile file(finalStripLocation);
  file.open(QIODevice::WriteOnly);

  // Finally, we save the image
  finalStrip.save(&file);

  // Wait for the image to be written, then close the file
  file.waitForBytesWritten(3000);
  file.close();

  // Tell android to scan the new file and add it to the Gallery
  QAndroidJniObject::callStaticMethod<void>("org/qtproject/qt5/android/multimedia/QtMultimediaUtils",
                                            "registerMediaFile",
                                            "(Ljava/lang/String;)V",
                                            QAndroidJniObject::fromString(file.fileName()).object());

  qDebug() << file.fileName();
  qDebug() << finalStripLocation;
  // And we tell the QML code where it is
  emit stripGenerated(finalStripLocation);
}

// This gets called when the capture object
// finishes saving the image
void CameraSource::pictureSaved(int id, QString imageLocation) {
  // Saves the image to RAM so we can quickly generate the
  // final image strip
  takenPictures[lastPictureNumber - 1] = new QImage(imageLocation);

  // Tell the QML code that it is taken, and where to find it
  emit pictureCaptured(imageLocation);
}

