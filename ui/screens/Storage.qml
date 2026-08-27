import QtQuick
import QtQuick.Controls
import "../components"

Item {
    Voltar{
        title:"screens/Menu.qml"
        imgsrc:"../../assets/back.svg"
    }
    property string folderPath: "/home/cotta/Documentos/fastAcquire"
        property var filesList: []
        property bool fileManagerAvailable: true // Since we confirmed it's working
    Component.onCompleted: {
            loadFiles()
        }

        function loadFiles() {
            filesList = fileManager.getFilesInFolder(folderPath)
            console.log("Found", filesList.length, "files in", folderPath)
        }

        function formatFileSize(bytes) {
            if (bytes < 0) return "Unknown"
            if (bytes < 1024) return bytes + " B"
            if (bytes < 1048576) return (bytes / 1024).toFixed(1) + " KB"
            return (bytes / 1048576).toFixed(1) + " MB"
        }

        function getFileName(fullPath) {
            return fileManager.getFileNameFromPath(fullPath)
        }

        function isDateValid(jsDate) {
            return jsDate && jsDate instanceof Date && !isNaN(jsDate.getTime());
        }
        function formatDateTime(jsDate) {
                if (!isDateValid(jsDate)) {
                    return "Data desconhecida"
                }

                try {
                    var day = jsDate.getDate().toString().padStart(2, '0')
                    var month = (jsDate.getMonth() + 1).toString().padStart(2, '0')
                    var year = jsDate.getFullYear()
                    var hours = jsDate.getHours().toString().padStart(2, '0')
                    var minutes = jsDate.getMinutes().toString().padStart(2, '0')
                    return day + "/" + month + "/" + year + " " + hours + ":" + minutes
                } catch (error) {
                    console.error("Error formatting date:", error)
                    return "Data inválida"
                }
            }
        Column {
                anchors.fill: parent
                anchors.topMargin: 40
                anchors.leftMargin: 10
                Row {
                    width: parent.width
                    height: 40
                    spacing: 20

                    Text {
                        text: "Pasta: " + folderPath
                        font.pixelSize: 14
                        color: "#666"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    //Button {
                    //    text: "🔄 Atualizar"
                    //    anchors.verticalCenter: parent.verticalCenter
                    //    onClicked: loadFiles()
                    //}

                    Text {
                        text: "Total: " + filesList.length + " arquivos"
                        font.pixelSize: 14
                        color: "#666"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                GridView {
                    id: gridView
                    width: parent.width
                    height: parent.height - 70
                    cellWidth: 180
                    cellHeight: 200
                    clip: true
                    x: 30
                    model: filesList

                    delegate: FAContainer {
                        width: gridView.cellWidth - 10
                        height: gridView.cellHeight - 10

                        fileName: getFileName(modelData)
                        filePath: modelData
                        fileSize: formatFileSize(fileManager.getFileSize(modelData))
                        fileDate: formatDateTime(fileManager.getFileCreatedTime(modelData))

                        onClicked: {
                            console.log("Arquivo clicado:", filePath)
                            showFileDetails(filePath)
                        }
                    }

                    Label {
                        anchors.centerIn: parent
                        text: filesList.length === 0 ? "Nenhum arquivo encontrado em:\n" + folderPath : "Carregando..."
                        visible: gridView.count === 0
                        horizontalAlignment: Text.AlignHCenter
                        color: "#666"
                    }

                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AsNeeded
                    }
                }
            }

            function showFileDetails(filePath) {
                var details = fileManager.getFileInfo(filePath)
                console.log("Detalhes do arquivo:", details)

                fileDetailsDialog.filePath = filePath
                fileDetailsDialog.fileInfo = details
                fileDetailsDialog.open()
            }

            Dialog {
                id: fileDetailsDialog
                title: "Detalhes do Arquivo"
                standardButtons: Dialog.Ok
                modal: true
                width: 400

                property string filePath: ""
                property string fileInfo: ""

                Column {
                    spacing: 10
                    anchors.fill: parent

                    Text {
                        text: "<b>Caminho:</b> " + fileDetailsDialog.filePath
                        font.pixelSize: 12
                        width: parent.width
                        wrapMode: Text.Wrap
                    }

                    Text {
                        text: fileDetailsDialog.fileInfo
                        font.pixelSize: 12
                        width: parent.width
                        wrapMode: Text.Wrap
                    }
                }
            }

}
