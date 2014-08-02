import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

ButtonStyle {
  background: Rectangle {
    color: "black"
    implicitWidth: 120
    implicitHeight: 75

    border.color: "#555"
    border.width: 1
    radius: 5

    gradient: Gradient {
      GradientStop { color: "#000"; position: control.pressed ? 0.0 : 1.0 }
      GradientStop { color: "#333"; position: control.pressed ? 1.0 : 0.0 }
    }
  }

  label: Text {
    anchors.fill: parent
    font.pixelSize: parent.height - 30
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    color: "#eee"
    text: control.text
  }
}
