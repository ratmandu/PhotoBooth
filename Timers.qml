import QtQuick 2.0

Component {
  Timer {
    id: countdownTimer
    running: false
    interval: 1000
  }

  Timer {
    id: afterPictureTimer
    running: false
    interval: 1500
  }

  Timer {
    id: finalImageDisplayTimer
    running: false
    interval: 5000
  }
}
