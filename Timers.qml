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
