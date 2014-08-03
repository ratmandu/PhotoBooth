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

#include <QDir>
#include <QPixmap>
#include <QApplication>
#include <QDesktopServices>
#include <QtQuick/QQuickItem>
#include <QQmlApplicationEngine>

#include "settings.h"
#include "camerasource.h"

int main(int argc, char *argv[])
{
  QApplication app(argc, argv);

  // we are going to need to check to see if our folders are
  // created already, or if this is the first run
  QString folder = QStandardPaths::writableLocation(QStandardPaths::PicturesLocation);
  folder.append("/Photobooth");

  // check if the Photobooth folder exists
  if (!QDir(folder).exists()) {
    // nope
    QDir dir(folder);
    folder.append("/%1");
    // lets create the folders we need
    dir.mkpath(folder.arg("Final"));
    dir.mkpath(folder.arg("SinglePics"));
  }

  // Register our CameraSource so our QML code can use it
  qmlRegisterType<CameraSource>("CameraSource", 1, 0, "CameraSource");

  // Same for our Settings class
  qmlRegisterType<Settings>("Settings", 1, 0, "Settings");

  // Here we are creating a blank cursor
  QPixmap emptyCursor(16, 16);

  // Filling it with transparent pixels
  emptyCursor.fill(Qt::transparent);

  // and setting it as the default application cursor
  //    app.setOverrideCursor(QCursor(emptyCursor));

  // We create a QML Application engine
  QQmlApplicationEngine engine;

  // And give it the location to our main qml file
  engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

  return app.exec();
}
