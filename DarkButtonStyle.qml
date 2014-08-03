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
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

// We want to make the buttons consistent with
// the rest of the application, so we style them
ButtonStyle {
  background: Rectangle {
    color: "black"
    implicitWidth: 120
    implicitHeight: 75

    border.color: "#555"
    border.width: 1
    radius: 5

    // we change the gradient depending on whether the button is
    // pressed or not. if it's pressed, we simply reverse it
    gradient: Gradient {
      GradientStop { color: "#000"; position: control.pressed ? 0.0 : 1.0 }
      GradientStop { color: "#333"; position: control.pressed ? 1.0 : 0.0 }
    }
  }

  label: Text {
    anchors.fill: parent
    font.pixelSize: parent.height - 30
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    color: "#eee"
    text: control.text
  }
}
