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
    //visibility: "FullScreen"

    Rectangle {
      id: mainBody
      anchors.fill: parent
      color: "black"

      Settings {
        id: settings
      }

      /*CameraSource {
        id: camera
      }*/

      PassDialog {
        id: passwordDialog

        onPasswordCorrect: {

        }

        onPasswordIncorrect: {

        }
      }
      /*
      VideoOutput {
        id: video
        visible: false
        source: camera
        anchors.fill: parent
      }
      */
    }

}
