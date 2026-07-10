import QtQuick
import QtQuick.Controls
import "../components"
Item {
    id: welcomeScreen
    anchors.fill: parent
    Image{
        height: 512
        width: 512
        anchors.centerIn: parent
        fillMode:Image.PreserveAspectFit
        source:"../../assets/logo2.png"
        MouseArea{
            anchors.fill: parent
            onClicked: window.currentScreen = "screens/Menu.qml"
        }
    }
}
