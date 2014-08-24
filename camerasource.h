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

#ifndef CAMERASOURCE_H
#define CAMERASOURCE_H

#include <QFile>
#include <QImage>
#include <QDebug>
#include <QPixmap>
#include <QObject>
#include <QCamera>
#include <QPainter>
#include <QDateTime>
#include <QMediaRecorder>
#include <QCameraControl>
#include <QDesktopServices>
#include <QCameraImageCapture>
#include <QVideoSurfaceFormat>
#include <QVideoEncoderSettings>
#include <QAbstractVideoSurface>

class CameraSource : public QObject
{
  Q_OBJECT

  // This exposes the videoSurface to our QML code, and allows reads and writes
  Q_PROPERTY(QAbstractVideoSurface *videoSurface READ videoSurface WRITE setVideoSurface)
public:
  explicit CameraSource(QObject *parent = 0);
  ~CameraSource();
  // Returns the videoSurface to the QML code, for display in a
  // QML VideoOutput element
  QAbstractVideoSurface* videoSurface() const { return m_surface; }

  // Used to set the videoSurface from QML or C++ code
  // videoSurface is created by the QML VideoOutput element and
  // set by it when the source is set
  Q_INVOKABLE void setVideoSurface(QAbstractVideoSurface *surface)
  {
    // set the surface
    m_surface = surface;
    // make sure the surface is valid before doing anything with it
    if (m_surface) {
      // start the surface
      m_surface->start(m_format);
      // set the surface as the viewfinder for the camera, for
      // live preview of the image
      camera->setViewfinder(m_surface);
      camera->start();
    }
  }

  // This will actually take a picture and store it in memory
  // and save the original to the drive
  Q_INVOKABLE void takePicture(int pictureNumber);

  // This will take a video and store it to the disk
  Q_INVOKABLE void startVideo();

  // This will stop the video recording
  Q_INVOKABLE void stopVideo();

  // This takes the previous images, and combines them into a
  // strip, then saves, and send the filename to the QML code
  Q_INVOKABLE void generateStrip(int numberOfPictures);

private:
  // our camera object
  QCamera *camera;

  // Our image capture object. This takes the pictures.
  QCameraImageCapture *capture;

  // Video recorder object. This takes the videos.
  QMediaRecorder *recorder;

  // This holds the actual image format the camera uses
  QVideoSurfaceFormat m_format;

  // This is our actual surface, that the camera image sits on in RAM
  QAbstractVideoSurface *m_surface;

  // stores the taken images until the final strip can be created and saved
  QImage *takenPictures[6];

  // stores the last image save location
  QString saveLocation;

  // Last picture number
  int lastPictureNumber;

signals:
  // tells the QML code where to find the single image
  void pictureCaptured(QString imageLocation);

  // tells the QML code where to find the final strip
  void stripGenerated(QString imageLocation);

public slots:
  // This is what actually sends the new frame off to the
  // QML code to be displayed
  void onNewVideoContentReceived(const QVideoFrame &frame)
  {
    // make sure the surface is valid
    if (m_surface) {
      // actually present the frame
      m_surface->present(frame);
    }
  }

private slots:
  // gets called by the capture object when it
  // finishes saving the image
  void pictureSaved(int id, QString imageLocation);

};

#endif // CAMERASOURCE_H
