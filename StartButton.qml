import QtQuick 2.0

Rectangle {
  signal buttonClicked()

  width: 200
  height: 125
  color: "black"

  radius: 10
  border.width: 1
  border.color: Qt.rgba(0.5, 0.5, 0.5, 0.75)

  gradient: Gradient {
    GradientStop { color: Qt.rgba(0, 0, 0, 0.75); position: 1.0 }
    GradientStop { color: Qt.rgba(0.25, 0.25, 0.25, 0.75); position: 0.0 }
  }

  Text {
    anchors.centerIn: parent

    color: "#eee"
    font.pixelSize: parent.height * 0.75

    text: "Go!"
  }

  MouseArea {
    anchors.fill: parent

    onClicked: buttonClicked()
  }
}
