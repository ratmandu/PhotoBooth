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

#include <QPixmap>
#include <QApplication>
#include <QtQuick/QQuickItem>
#include <QQmlApplicationEngine>

#include "settings.h"
#include "camerasource.h"

int main(int argc, char *argv[])
{
  QApplication app(argc, argv);

  // Register our CameraSource so our QML code can use it
  qmlRegisterType<CameraSource>("CameraSource", 1, 0, "CameraSource");
  qmlRegisterType<Settings>("Settings", 1, 0, "Settings");

  QPixmap emptyCursor(16, 16);
  emptyCursor.fill(Qt::transparent);
  //    app.setOverrideCursor(QCursor(emptyCursor));

  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

  return app.exec();
}
