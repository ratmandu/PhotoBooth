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

import QtQuick 2.0

Rectangle {

  property alias countDownNumber: countNumber.text

  width: 250
  height: 250
  radius: 15
  color: Qt.rgba(0,0,0,0.2)
  border.width: 1
  border.color: Qt.rgba(0.25, 0.25, 0.25, 0.5)
  antialiasing: true

  Text {
    id: countNumber
    anchors.centerIn: parent
    font.pixelSize: parent.height
    color: "white"
    antialiasing: true
    opacity: 1.0

    renderType: Text.NativeRendering
  }
}
