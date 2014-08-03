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

      }
    }
  }

  Timer {
    id: afterPictureTimer
    running: false
    interval: settings.getInt("afterPictureTimerInterval", 1500)
  }

  Timer {
    id: finalImageDisplayTimer
    running: false
    interval: settings.getInt("finalImageDisplayTimerInterval", 5000)
  }
}
