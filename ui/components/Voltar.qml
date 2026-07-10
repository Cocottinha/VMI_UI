import QtQuick 2.15
import QtQuick.Controls
Item {
    property string id
    property string title
    property string imgsrc
    Rectangle{
        width: 80
        height: 50
        id:id
        radius:50
        color: "#404041"
        x:920
        y:20
        MouseArea{
            anchors.fill: parent
            onClicked: window.currentScreen = title

        }
        Image{
            height: 32
            width: 32
            anchors.centerIn: parent
            fillMode:Image.PreserveAspectFit
            source:imgsrc
        }
    }
}
