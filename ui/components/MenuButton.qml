import QtQuick 2.15

Item {
    property string itemId
    property string title
    property string imgsrc
    property string pagesrc
    id:itemId
    Rectangle{
        width: 280
        height: 200

        id:id
        radius:50
        color: "#404041"
        Image{
            id:iconImage
            height: 64
            width: 64
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode:Image.PreserveAspectFit
            source:imgsrc
        }
        MouseArea{
            anchors.fill: parent
            onClicked: window.currentScreen = pagesrc
        }

        Text {
                text: qsTr(title)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 100 // Ajuste esse valor como preferir

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#f4b41f"
                font {
                    family: "fontFamily"
                    bold: true
                    pixelSize: 36
                }
            }
    }
}
