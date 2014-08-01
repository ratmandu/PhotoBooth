import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2

Rectangle {
  anchors.fill: parent
  color: "black"

  Column {
    id: passColumn
    anchors.fill: parent
    spacing: 20

    Text {
      color: "White"
      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: Text.AlignHCenter
      font.pixelSize: 30
      text: "Please enter setup PIN"
    }

    TextField {
      id: passwordField
      height: 50
      width: parent.width / 2
      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: TextInput.AlignHCenter
      placeholderText: "Please enter setup pin."
    }
  }
}
