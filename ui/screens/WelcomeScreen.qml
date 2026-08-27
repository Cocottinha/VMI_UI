import QtQuick
import QtQuick.Controls
import "../components"

Item {
    id: welcomeScreen
    anchors.fill: parent

    // Instancia o componente da animação do logotipo no centro da tela
    // (Certifique-se de que o arquivo LogoAnimation.qml está na pasta components)
    LogoAnimada {
        anchors.centerIn: parent
        width: 600
        height: 600
    }
    Image{
        source: "../../assets/logonome.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        width: 500
        fillMode: Image.PreserveAspectFit
    }

    // Área de clique caso o usuário queira pular antes do tempo
    MouseArea {
        anchors.fill: parent
        onClicked: window.currentScreen = "screens/Menu.qml"
    }
    Image {
        id: vmi
        x:920
        y:530
        source: "../../assets/vmi.png"
        width: 90
        height: 60
        fillMode: Image.PreserveAspectFit
    }
    // Timer para mudar de tela automaticamente após 3 segundos
    Timer {
        id: transitionTimer
        interval: 5000 // 3 segundos
        running: true
        repeat: false
        onTriggered: {
            window.currentScreen = "screens/Menu.qml"
        }
    }
}
