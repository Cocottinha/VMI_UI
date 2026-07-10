import QtQuick
import QtQuick.Controls
import "../components"
Item {
    id: menuScreen
    width: 1024
    height: 600
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        color: "#f0f0f0" // Light grey background for the menu
    }
    MenuButton{
        itemId:"aquisicao"
        title:"Aquisição"
        y:190
        x:80
        pagesrc:"screens/Aquisition.qml"
        imgsrc:"../../assets/aquisition.svg"
    }
    MenuButton{
        itemId:"storage"
        title:"Armazen."
        y:190
        x:380
        imgsrc:"../../assets/storage.svg"
    }
    MenuButton{
        itemId:"config"
        title:"Configs."
        y:190
        x:680
        imgsrc:"../../assets/config.svg"
    }
    Voltar{
        title:"screens/WelcomeScreen.qml"
        imgsrc:"../../assets/back.svg"
    }
}
