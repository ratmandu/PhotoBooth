#ifndef CAMERASOURCE_H
#define CAMERASOURCE_H

#include <QImage>
#include <QObject>
#include <QCamera>
#include <QCameraControl>
#include <QCameraImageCapture>
#include <QAbstractVideoSurface>

class CameraSource : public QObject
{
  Q_OBJECT
public:
  explicit CameraSource(QObject *parent = 0);

signals:

public slots:

};

#endif // CAMERASOURCE_H
