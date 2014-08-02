import QtQuick 2.0

Rectangle {
  width: 100
  height: 100
  color: "transparent"

  signal buttonClick()

  MouseArea {
    anchors.fill: parent

    onClicked: buttonClick()
  }
}
