import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

TextFieldStyle {
  textColor: "white"

  background: Rectangle {
    color: "black"
    radius: 5
    implicitWidth: 100
    implicitHeight: 24
    border.color: "#555"
    border.width: 1

    gradient: Gradient {
      GradientStop { color: "#000"; position: 1.0 }
      GradientStop { color: "#333"; position: 0.0 }
    }
  }
}
