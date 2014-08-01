import QtQuick 2.2
import QtQuick.Controls 1.1
import QtMultimedia 5.3

import CameraSource 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Makers Local 256 Photobooth")

    Rectangle {
      id: mainBody
      anchors.fill: parent

      CameraSource {
        id: camera
      }

      VideoOutput {
        id: video
        visible: true
        source: camera
        anchors.fill: parent
      }
    }

}
