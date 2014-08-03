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

// This is our countdown display, which gives
// the user an indication of when the picture
// will be taken.
Rectangle {
  // we use a property alias here to be able to set
  // the count down number from outside
  property alias countDownNumber: countNumber.text

  width: 250
  height: 250

  // make the rectangle rounded
  radius: 15

  // We want it mostly transparent
  color: Qt.rgba(0,0,0,0.2)

  // With a pretty, decently transparent border
  border.width: 1
  border.color: Qt.rgba(0.25, 0.25, 0.25, 0.5)

  // make sure it is smooth
  antialiasing: true

  // This is our actual number display
  Text {
    id: countNumber
    // center it
    anchors.centerIn: parent
    // make the text the same height as the rectangle
    font.pixelSize: parent.height
    // we want to be able to see it, against the dark background
    color: "white"
    // make it smooth
    antialiasing: true
    // make it completely opaque
    opacity: 1.0

    // We want to use the OS's native rendering for the font
    // this makes it much nicer to look at, with giant size
    renderType: Text.NativeRendering
  }
}
