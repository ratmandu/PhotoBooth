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

// this holds all of our timer logic
Item {
  property alias countdownTimer: countdownTimer
  property alias afterPictureTimer: afterPictureTimer
  property alias finalImageDisplayTimer: finalImageDisplayTimer

  // timer for the countdown, which gives the
  // users time to prepare for the photo
  Timer {
    id: countdownTimer
    running: false
    interval: settings.getInt("countDownTimer", 1000)

    // what to do when the timer has finished
    onTriggered: {
      // if we have more time to go
      if (counters.countDownCounter > 0) {
        // decrease the number of seconds
        counters.countDownCounter -= 1
        // start the timer again
        countdownTimer.start()
      } else if (counters.countDownCounter == 0) { // Time's up!
        // capture the picture
        camera.takePicture(counters.imageCount)
        // hide the countdown display
        countDown.visible = false
        // reset the counter
        counters.countDownCounter = settings.getInt("CountDownCounter", 3)
      }
    }
  }

  // this timer controls how long the user will see the
  // last picture that was taken
  Timer {
    id: afterPictureTimer
    running: false
    // this is the actual time the software will pause on the image
    interval: settings.getInt("afterPictureTimerInterval", 1500)

    onTriggered: {
      // hide the picture
      pictureDisplay.visible = false
      // show the video preview
      video.visible = true
      // show the countdown
      countDown.visible = true
      // do we have more pictures to take?
      if (counters.imageCount - 1 > 0) {
        // yes, decrease the number of pictures we still need
        counters.imageCount -= 1
        // start the countdown timer
        countdownTimer.start()
      } else {
        // nope, reset the number of pictures needed
        counters.imageCount = settings.getInt("ImageCount", 4)
        // generate the final picture strip
        camera.generateStrip(settings.getInt("ImageCount", 4))
      }
    }
  }

  // this timer controls how long the user will see the final image strip
  Timer {
    id: finalImageDisplayTimer
    running: false
    interval: settings.getInt("finalImageDisplayTimerInterval", 5000)

    onTriggered: {
      // hide the picture
      pictureDisplay.visible = false
      // show the video preview
      video.visible = true
      // show the start button, so the next user can take some pictures
      startButton.visible = true
    }
  }
}
