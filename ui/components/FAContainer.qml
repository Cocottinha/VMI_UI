import QtQuick
import QtQuick.Controls

Rectangle {
    id: container

    // Propriedades expostas para receber os dados do arquivo
    property string fileName: ""
    property string filePath: ""
    property string fileSize: ""
    property string fileDate: ""

    signal clicked()

    width: 170
    height: 190
    color: mouseArea.containsMouse ? "#f0f4f8" : "#ffffff"
    border.color: mouseArea.containsMouse ? "#007bff" : "#e0e0e0"
    border.width: 1
    radius: 10

    Behavior on color { ColorAnimation { duration: 150 } }
    Behavior on border.color { ColorAnimation { duration: 150 } }

    Column {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        // Ícone ou representação visual do arquivo
        Rectangle {
            width: parent.width
            height: 70
            color: "#eef2f7"
            radius: 6

            Text {
                anchors.centerIn: parent
                text: "📄"
                font.pixelSize: 32
            }
        }

        // Nome do Arquivo
        Text {
            text: container.fileName
            font.bold: true
            font.pixelSize: 13
            color: "#333333"
            width: parent.width
            elide: Text.ElideMiddle
            maximumLineCount: 1
        }

        // Tamanho do Arquivo
        Text {
            text: "Tamanho: " + container.fileSize
            font.pixelSize: 11
            color: "#666666"
        }

        // Data do Arquivo
        Text {
            text: "Data: " + container.fileDate
            font.pixelSize: 10
            color: "#888888"
            elide: Text.ElideRight
            width: parent.width
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: container.clicked()
    }
}
