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

Item {
  property alias countdownTimer: countdownTimer
  property alias afterPictureTimer: afterPictureTimer
  property alias finalImageDisplayTimer: finalImageDisplayTimer

  Timer {
    id: countdownTimer
    running: false
    interval: settings.getInt("countDownTimer", 1000)

    onTriggered: {
      if (counters.countDownCounter > 0) {
        counters.countDownCounter -= 1
        countdownTimer.start()
      } else if (counters.countDownCounter == 0) {
        camera.takePicture(counters.imageCount)
        counters.countDownCounter = settings.getInt("CountDownCounter", 3)
      }
    }
  }

  Timer {
    id: afterPictureTimer
    running: false
    interval: settings.getInt("afterPictureTimerInterval", 1500)

    onTriggered: {
      pictureDisplay.visible = false
      video.visible = true
      countDown.visible = true
      if (counters.imageCount - 1 > 0) {
        counters.imageCount -= 1
        countdownTimer.start()
      } else {
        counters.imageCount = settings.getInt("ImageCount", 4)
        // TODO: Generate final strip here
        camera.generateStrip(settings.getInt("ImageCount", 4))
      }
    }
  }

  Timer {
    id: finalImageDisplayTimer
    running: false
    interval: settings.getInt("finalImageDisplayTimerInterval", 5000)

    onTriggered: {
      pictureDisplay.visible = false
      video.visible = true
      startButton.visible = true
    }
  }
}
