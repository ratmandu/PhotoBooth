import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2

Rectangle {
  anchors.fill: parent
  color: "black"

  signal passwordCorrect()
  signal passwordIncorrect()

  Column {
    id: passColumn
    anchors.fill: parent
    anchors.topMargin: 15
    anchors.bottomMargin: 15
    spacing: 20

    Text {
      color: "#eee"
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
      echoMode: TextInput.Password
      placeholderText: "Please enter setup pin."

      style: DarkTextFieldStyle{}
    }

    GridLayout {
      rows: 4
      columns: 3

      columnSpacing: 1
      rowSpacing: 1

      anchors.horizontalCenter: parent.horizontalCenter

      Layout.minimumHeight: 25
      Layout.minimumWidth: 25

      Button {
        text: "1"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: passwordField.insert(passwordField.length, text)
      }

      Button {
        text: "2"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: passwordField.insert(passwordField.length, text)
      }

      Button {
        text: "3"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: passwordField.insert(passwordField.length, text)
      }

      Button {
        text: "4"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: passwordField.insert(passwordField.length, text)
      }

      Button {
        text: "5"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: passwordField.insert(passwordField.length, text)
      }

      Button {
        text: "6"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: passwordField.insert(passwordField.length, text)
      }

      Button {
        text: "7"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: passwordField.insert(passwordField.length, text)
      }

      Button {
        text: "8"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: passwordField.insert(passwordField.length, text)
      }

      Button {
        text: "9"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: passwordField.insert(passwordField.length, text)
      }

      Button {
        text: "Clear"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: passwordField.text = ""
      }

      Button {
        text: "0"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: passwordField.insert(passwordField.length, text)
      }

      Button {
        text: "Enter"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: {
          checkPassword(passwordField.text)
          passwordField.text = ""
        }
      }
    }
  }

  // this function checks to see if the correct password was entered
  // if password has not previously been set, it defaults to 0000
  function checkPassword(entered) {
    if (entered == settings.getString("SettingsPass", "0000")) {
      console.log("Correct!")
      passwordCorrect()
    } else {
      console.log("Incorrect!")
      passwordIncorrect()
    }
  }
}

