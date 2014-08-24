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

// This button starts the photobooth process
Rectangle {
  signal buttonClicked()

  property alias buttonText: textOnButton.text

  width: textOnButton.width + 20
  height: 200
  color: "black"

  radius: 10
  border.width: 1
  border.color: Qt.rgba(0.5, 0.5, 0.5, 0.75)

  // we want a slightly transparent button
  gradient: Gradient {
    GradientStop { color: Qt.rgba(0, 0, 0, 0.75); position: mousearea.pressed ? 0.0 : 1.0 }
    GradientStop { color: Qt.rgba(0.25, 0.25, 0.25, 0.75); position: mousearea.pressed ? 1.0 : 0.0 }
  }

  Text {
    id: textOnButton
    anchors.centerIn: parent

    color: "#eee"
    font.pixelSize: parent.height * 0.75

    text: "Go!"
  }

  MouseArea {
    id: mousearea
    anchors.fill: parent
    onClicked: buttonClicked()
  }
}
