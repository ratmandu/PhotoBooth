import QtQuick 2.0

Rectangle {

  property alias countDownNumber: countNumber.text

  width: 250
  height: 250
  radius: 15
  color: Qt.rgba(0,0,0,0.2)
  border.width: 1
  border.color: Qt.rgba(0.25, 0.25, 0.25, 0.5)
  antialiasing: true

  Text {
    id: countNumber
    anchors.centerIn: parent
    font.pixelSize: parent.height

//    text: "3"
    color: "white"
    antialiasing: true
    opacity: 1.0

    renderType: Text.NativeRendering
  }
}
