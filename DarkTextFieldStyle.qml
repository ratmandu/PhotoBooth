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

// We want to make the TextField consistent
// with the rest of the application's looks
TextFieldStyle {
  textColor: "white"

  background: Rectangle {
    color: "black"
    radius: 5
    implicitWidth: 100
    implicitHeight: 24
    border.color: "#555"
    border.width: 1

    gradient: Gradient {
      GradientStop { color: "#000"; position: 1.0 }
      GradientStop { color: "#333"; position: 0.0 }
    }
  }
}
