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

import QtQuick 2.2
import QtQuick.Controls 1.1
import QtMultimedia 5.3

import CameraSource 1.0
import Settings 1.0

ApplicationWindow {
  visible: true
  width: 1280
  height: 720
  title: qsTr("Makers Local 256 Photobooth")

  // uncomment this to make the application full screen
  //    visibility: "FullScreen"

  Rectangle {
    id: mainBody
    anchors.fill: parent
    color: "black"

    Settings {
      id: settings
    }

    CameraSource {
      id: camera

      onPictureCaptured: {
        pictureDisplay.source = "file:///" + imageLocation
        pictureDisplay.visible = true
        video.visible = false
        countDown.visible = false
        timers.afterPictureTimer.start()
      }

      onStripGenerated: {
        pictureDisplay.source = "file:///" + imageLocation
        pictureDisplay.visible = true
        video.visible = false
        countDown.visible = false
        timers.finalImageDisplayTimer.start()
      }
    }

    Timers {
      id: timers
    }

    PassDialog {
      id: passwordDialog
      visible: false

      onPasswordCorrect: {
      }

      onPasswordIncorrect: {
        passwordDialog.visible = false
        video.visible = true
      }
    }

    Image {
      id: pictureDisplay
      fillMode: Image.PreserveAspectFit
      visible: false
      anchors.fill: parent
    }

    VideoOutput {
      id: video
      source: camera
      anchors.fill: parent
    }

    Counters {
      id: counters
    }

    CountdownDisplay {
      id: countDown
      visible: false
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      anchors.topMargin: 20
      countDownNumber: counters.countDownCounter
    }

    StartButton {
      id: startButton
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      anchors.topMargin: 20

      visible: true

      onButtonClicked: {
        startButton.visible = false
        countDown.visible = true
        timers.countdownTimer.start()
      }
    }

    InvisiButton {
      id: settingsButton
      width: 150
      height: 150
      anchors.top: parent.top
      anchors.right: parent.right

      onButtonClick: {
        passwordDialog.visible = true
        video.visible = false
      }
    }
  }

}
