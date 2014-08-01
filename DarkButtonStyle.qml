import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

ButtonStyle {
  background: Rectangle {
    color: "black"
    implicitWidth: 100
    implicitHeight: 25

    border.color: "#555"
    border.width: 1
    radius: 5

    gradient: Gradient {
      GradientStop { color: "#000"; position: 1.0 }
      GradientStop { color: "#333"; position: 0.0 }
    }
  }

  label: Text {
    anchors.fill: parent
    font.pixelSize: parent.height - 8
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    color: "#eee"
    text: control.text
  }
}
