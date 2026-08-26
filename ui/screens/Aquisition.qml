import QtQuick
import QtQuick.Controls
import "../components"

Item {
    id: aquisitionScreen

    // Dados de exemplo para os perfis
    readonly property var perfisData: [
        { texto1: "Voltagem: 100kV", texto2: "Amperagem: 100mA", texto3: "Tempo: 30s" },
        { texto1: "Voltagem: 200kV", texto2: "Amperagem: 150mA", texto3: "Tempo: 30s" },
        { texto1: "Voltagem: 150kV", texto2: "Amperagem: 100mA", texto3: "Tempo: 30s" },
        { texto1: "Voltagem: 150kV", texto2: "Amperagem: 150mA", texto3: "Tempo: 30s" },
        { texto1: "Voltagem: 200kV", texto2: "Amperagem: 150mA", texto3: "Tempo: 15s" }
    ]

    // Índice do perfil atualmente selecionado
    property int perfilSelecionado: 0

    // Fundo ou container principal preenchendo a tela
    Item {
        anchors.fill: parent

        // --- COLUNA LATERAL: 5 Radio Buttons ---
        Column {
            id: sidebar
            spacing: 25
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.verticalCenter: parent.verticalCenter

            Text {
                text: "Perfis"
                font.bold: true
                font.pixelSize: 30
            }

            ButtonGroup { id: perfilGroup }

            Repeater {
                model: 5
                delegate: RadioButton {
                    required property int index
                    text: "Perfil " + (index + 1)
                    checked: index === 0
                    ButtonGroup.group: perfilGroup
                    font.pixelSize: 30

                    onCheckedChanged: {
                        if (checked) {
                            aquisitionScreen.perfilSelecionado = index
                        }
                    }
                }
            }
        }

        // --- COLUNA CENTRAL: Título, 3 Textos e Botão Iniciar ---
        Column {
            id: contentArea
            spacing: 20
            // Posiciona o bloco no centro da tela, um pouco deslocado para a direita da sidebar
            anchors.centerIn: parent
            // Se quiser que fique um pouco mais para o centro geral da janela, ajuste o offset horizontal se necessário:
            x: (parent.width / 2) - (width / 2) + 60

            Text {
                text: "Aquisição"
                font.pixelSize: 36
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Espaçamento visual extra abaixo do título
            Item { width: 1; height: 10 }

            Text {
                text: aquisitionScreen.perfisData[aquisitionScreen.perfilSelecionado].texto1
                font.pixelSize: 30
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: aquisitionScreen.perfisData[aquisitionScreen.perfilSelecionado].texto2
                font.pixelSize: 30
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: aquisitionScreen.perfisData[aquisitionScreen.perfilSelecionado].texto3
                font.pixelSize: 30
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Espaçamento visual antes do botão
            Item { width: 1; height: 15 }

            Button {
                id:startButton
                text: "Iniciar"
                contentItem: Text {
                        text: startButton.text
                        color: "#f4b41f" // <--- Altere a cor do texto aqui
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.bold:true
                        font.pixelSize: 30
                    }
                width: 140
                height: 60
                background: Rectangle {
                                    color:"#404041"
                                    border.color: "#404041"
                                    border.width: 1
                                    radius: 50 // Aqui você define o arredondamento das bordas
                                }
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    console.log("Iniciando com o Perfil: " + (aquisitionScreen.perfilSelecionado + 1))
                    onClicked: window.currentScreen = "screens/Graph.qml"
                }
            }
        }
    }

    // Botão Voltar
    Voltar {
        title: "screens/Menu.qml"
        imgsrc: "../../assets/back.svg"
    }
}
