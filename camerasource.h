#ifndef CAMERASOURCE_H
#define CAMERASOURCE_H

#include <QImage>
#include <QDebug>
#include <QPixmap>
#include <QObject>
#include <QCamera>
#include <QPainter>
#include <QDateTime>
#include <QCameraControl>
#include <QDesktopServices>
#include <QCameraImageCapture>
#include <QVideoSurfaceFormat>
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
    }
  }

  // This will actually take a picture and store it in memory
  // and save the original to the drive
  Q_INVOKABLE void takePicture(int pictureNumber);

  // This takes the previous images, and combines them into a
  // strip, then saves, and send the filename to the QML code
  Q_INVOKABLE void generateStrip(int numberOfPictures);

private:
  // our camera object
  QCamera *camera;

  // Our image capture object. This takes the pictures.
  QCameraImageCapture *capture;

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
  void pictureCaptured(QString imageLocation);
  void stripGenerated(QString imageLocation);

public slots:
  // This is what actually sends the new frame off to the
  // QML code to be displayed
  void onNewVideoContentReceived(const QVideoFrame &frame)
  {
    // make sure the surface is valid
    if (m_surface)
      m_surface->present(frame); // <-- present the frame
  }

private slots:
  void pictureSaved(int id, QString imageLocation);

};

#endif // CAMERASOURCE_H
