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

// This is an invisible button,
// which we will use to open the
// settings panel
Rectangle {
  width: 100
  height: 100
  color: "transparent"

  // our signal that tells the main code
  // that we have been clicked
  signal buttonClick()

  // the actual area that the mouse interacts with
  MouseArea {
    anchors.fill: parent

    onClicked: buttonClick()
  }
}
