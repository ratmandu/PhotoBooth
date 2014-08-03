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

// import our custom C++ types
import CameraSource 1.0
import Settings 1.0

// this is our main application window
ApplicationWindow {
  visible: true

  // set a default width and height
  width: 1280
  height: 720

  // and window title
  title: qsTr("Makers Local 256 Photobooth")

  // uncomment this to make the application full screen
  //    visibility: "FullScreen"

  Rectangle {
    id: mainBody
    anchors.fill: parent
    color: "black"

    // our settings element
    Settings {
      id: settings
    }

    // our camera source
    CameraSource {
      id: camera

      // when the capture object saves a picture
      // this gets called
      onPictureCaptured: {
        // we set the file name as the image source
        pictureDisplay.source = "file:///" + imageLocation
        // set it to be visible
        pictureDisplay.visible = true
        // hide the video preview
        video.visible = false
        // hide the countdown
        countDown.visible = false
        // start the after picture timer
        timers.afterPictureTimer.start()
      }

      // when the final image strip is generated
      // this gets called
      onStripGenerated: {
        // set our source to the file name
        // of the final strip image
        pictureDisplay.source = "file:///" + imageLocation
        // Set it to be visible
        pictureDisplay.visible = true
        // hide the video preview
        video.visible = false
        // hide the countdown
        countDown.visible = false
        // start the final image display timer
        timers.finalImageDisplayTimer.start()
      }
    }

    // create our timers
    Timers {
      id: timers
    }

    // create the password dialog
    PassDialog {
      id: passwordDialog

      // hide it by default, as we
      // dont want to see it yet
      visible: false

      // This is what we do when a correct password
      // was entered
      onPasswordCorrect: {
      }

      // and what we do when the password is incorrect
      onPasswordIncorrect: {
        // hide the dialog
        passwordDialog.visible = false

        // show the video preview again
        video.visible = true
      }
    }

    // our image display element
    Image {
      id: pictureDisplay
      // make sure the image isn't cut off, or shown weirdly
      fillMode: Image.PreserveAspectFit
      // we dont want to see it yet
      visible: false
      // fill the screen (or at least the window)
      anchors.fill: parent
    }

    // this is our video preview element
    VideoOutput {
      id: video
      // we want to see the camera output as a preview
      source: camera
      // fill the screen/window
      anchors.fill: parent
    }

    // our counter storage
    Counters {
      id: counters
    }

    // this is our countdown display
    CountdownDisplay {
      id: countDown
      // we dont want to see it by default
      visible: false
      // center it horizontally in the application
      anchors.horizontalCenter: parent.horizontalCenter
      // make it stick 20px below the top
      anchors.top: parent.top
      anchors.topMargin: 20

      // set our number, to the countdownnumber
      countDownNumber: counters.countDownCounter
    }

    // This button starts our picture taking spree
    StartButton {
      id: startButton
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      anchors.topMargin: 20

      // we do want to see it by default
      visible: true

      // heres what we do when we're clicked
      onButtonClicked: {
        // hide the button
        startButton.visible = false
        // make sure we can see the countdown
        countDown.visible = true
        // start the countdown timer
        timers.countdownTimer.start()
      }
    }

    // this is our invisible settings button
    InvisiButton {
      id: settingsButton
      // we make it nice and square
      width: 150
      height: 150

      // put it in the top right corner
      anchors.top: parent.top
      anchors.right: parent.right

      // we want to go to the password dialog first
      // when the button is clicked
      // and then hide the video preview
      onButtonClick: {
        passwordDialog.visible = true
        video.visible = false
      }
    }
  }

}
