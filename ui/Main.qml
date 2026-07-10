import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls

Window {
    id: window // <-- The ID is "window"
    width: 1024
    height: 600
    visible: true
    title: qsTr("OreSpectra v1.1")
    color: "#f0f0f0" // Light grey background for the menu

    // Changed initial screen to a dedicated Welcome/Splash screen
    property string currentScreen: "screens/WelcomeScreen.qml"

    Loader {
        id: screenLoader
        anchors.fill: parent

        // Fixed reference to use "window" instead of "mainWindow"
        source: window.currentScreen

        asynchronous: true
        opacity: status === Loader.Ready ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 200 } }
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    // Version label stays globally visible on all screens
    Text {
        id: _text
        x: 8
        y: 580
        text: qsTr("OreSpectra v1.1-Release")
        font.pixelSize: 12
        z: 10 // Keeps it visible above loaded screens
    }
}
