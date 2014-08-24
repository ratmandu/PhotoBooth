/*
  Copyright (C) 2014 - Justin Richards

  This file is part of Photobooth.

  Photobooth is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  Photobooth is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Photobooth.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2

// this is our quick and simple numeric pin based
// password dialog, with buttons!
Rectangle {
  anchors.fill: parent
  color: "black"

  // signals to tell the rest of the code if the
  // entered password was correct or not
  signal passwordCorrect()
  signal passwordIncorrect()

  property bool passwordChange: false

  Column {
    id: passColumn
    anchors.fill: parent
    anchors.topMargin: 15
    anchors.bottomMargin: 15
    spacing: 20

    // we have some prompting text to tell the
    // user what to do, because stupid users
    Text {
      color: "#eee"
      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: Text.AlignHCenter
      font.pixelSize: 30
      text: passwordChange ? "Please enter new PIN" : "Please enter setup PIN"
    }

    // our text field that holds the password
    TextField {
      id: passwordField
      height: 50
      width: parent.width / 2
      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: TextInput.AlignHCenter
      // we are entering a password, so dont actually
      // echo back the password, just character placeholders
      echoMode: TextInput.Password

      // apply our dark style
      style: DarkTextFieldStyle{}
    }

    GridLayout {
      rows: 4
      columns: 3

      columnSpacing: 1
      rowSpacing: 1

      anchors.horizontalCenter: parent.horizontalCenter

      // here we create buttons, i only need to comment one of them
      // since they are all pretty much the same
      Button {
        text: "1"
        // make sure we fill the grid cell with the button
        Layout.fillWidth: true
        Layout.fillHeight: true
        // set our dark style
        style: DarkButtonStyle {}

        // and we add this character to the password textfield when clicked
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

      // clear the password field
      Button {
        text: "Clear"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        // empty that thing out!
        onClicked: passwordField.text = ""
      }

      Button {
        text: "0"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: passwordField.insert(passwordField.length, text)
      }

      // we've entered the password, check it
      Button {
        text: "Enter"
        Layout.fillWidth: true
        Layout.fillHeight: true
        style: DarkButtonStyle {}

        onClicked: {
          // lets check the password
          checkPassword(passwordField.text)
          // clear the password field out
          passwordField.text = ""
        }
      }
    }
  }

  // this function checks to see if the correct password was entered
  // if password has not previously been set, it defaults to 0000
  function checkPassword(entered) {
    // check yourself
    if (entered == settings.getString("SettingsPass", "0000")) {
      console.log("Correct password!")
      passwordCorrect()
    } else { // before you wreck yourself
      console.log("Incorrect password!")
      passwordIncorrect()
    }
  }
}

