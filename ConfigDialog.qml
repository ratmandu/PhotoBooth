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
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

// This holds all of our controls for changing settings
Rectangle {
  anchors.fill: parent
  color: "black"

  signal dialogClosed()

  // TODO: Actually create the controls for changing settings
  Rectangle {
    id: controlRect
    color: "black"
    width: parent.width
    height: parent.height - 100
    anchors.top: parent.top
    anchors.left: parent.left

    GridLayout {
      id: controlGrid
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.topMargin: 20
      anchors.leftMargin: 20

      columnSpacing: 20
      rowSpacing: 20

      columns: 2

      Text {
        color: "white"
        font.pixelSize: 20
        text: "Number of pictures:"
      }

      Row {
        spacing: 15

        Slider {
          id: pictureNumberSlider
          minimumValue: 2
          maximumValue: 10
          stepSize: 1

          value: settings.getInt("ImageCount", 3)
        }

        Text {
          color: "white"
          font.pixelSize: 20
          text: pictureNumberSlider.value.toString()
        }
      }

      Text {
        color: "white"
        font.pixelSize: 20
        text: "Seconds for setup:"
      }

      Row {
        spacing: 15

        Slider {
          id: setupTimeSlider
          minimumValue: 1
          maximumValue: 30
          stepSize: 1

          value: settings.getInt("CountDownCounter", 4)
        }

        Text {
          color: "white"
          font.pixelSize: 20
          text: setupTimeSlider.value
        }
      }
    }

  }

  Rectangle {
    id: buttonRect
    color: "#252525"
    width: parent.width
    height: 100
    anchors.top: controlRect.bottom
    anchors.left: parent.left

    Button {
      id: saveButton
      text: "Save"
      anchors.right: parent.right
      anchors.rightMargin: 25
      anchors.verticalCenter: parent.verticalCenter
      height: 75
      width: 200
      style: DarkButtonStyle {}

      onClicked: {
        saveSettings()
        dialogClosed()
      }
    }

    Button {
      id: cancelButton
      text: "Cancel"
      anchors.right: saveButton.left
      anchors.rightMargin: 25
      anchors.verticalCenter: parent.verticalCenter
      height: 75
      width: 200
      style: DarkButtonStyle {}

      onClicked: {
        loadSettings()
        dialogClosed()
      }
    }
  }

  function saveSettings() {
    // TODO: Save settings and close the panel here
    settings.setInt("CountDownCounter", setupTimeSlider.value)
    settings.setInt("ImageCount", pictureNumberSlider.value)

    counters.countDownCounter = setupTimeSlider.value
    counters.imageCount = pictureNumberSlider.value

    dialogClosed()
  }

  function loadSettings() {
    // TODO: load all the settings here
  }
}

