import QtQuick
import QtQuick.Effects
Item {
    id: logoAnimationScreen
    width: 500
    height: 500

    // Container central do logotipo
    Item {
        anchors.centerIn: parent
        width: 500
        height: 500

        // 1. Guarda-chuva Fixo
        Image {
            id: umbrella
            source: "../../assets/logosemnome.png"
            x: (parent.width - width) / 2
            y: 0
            width: 380
            height: 380
            fillMode: Image.PreserveAspectFit
            // SequentialAnimation {
            //     running: true
            //     loops: Animation.Infinite

            //     ScaleAnimator {
            //         target: umbrella
            //         from: 0.8
            //         to: 0.9
            //         duration: 1500
            //         easing.type: Easing.InOutQuad
            //          // Sine é ainda mais suave que Quad para fade
            //     }
            //     ScaleAnimator {
            //         target: umbrella
            //         from:0.9
            //         to: 0.8
            //         duration: 1500
            //         easing.type: Easing.InOutQuad
            //     }
            // }
        }
        // 2. Feixe de Luz (Arco-íris) subindo e descendo
        Rectangle {
                    id: horizontalBar
                    width: 400
                    radius: 10
                    height: 5 // Altura da barra
                    color: "#222222" // Cor da barra (você pode mudar para qualquer cor ou usar um Gradiente)

                    // Centralizada horizontalmente, e com o Y animado
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 0 // Posição base inicial
                    layer.enabled: true
                                layer.effect: MultiEffect {
                                    shadowEnabled: true      // Ativa a sombra
                                    shadowColor: "#30000000" // Cor da sombra (com transparência)
                                    shadowBlur: 0.5          // Suavidade/desfoque da sombra
                                    shadowVerticalOffset: 6  // Deslocamento para baixo
                                    shadowHorizontalOffset: 2
                                }
                    // Animação contínua de subida e descida sem trancos
                    SequentialAnimation {
                        running: true
                        loops: Animation.Infinite

                        NumberAnimation {
                            target: horizontalBar
                            property: "y"
                            from: -20    // Ponto mais alto que ela sobe
                            to: 390     // Ponto mais baixo que ela desce
                            duration: 2500
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            target: horizontalBar
                            property: "y"
                            from: 390
                            to: -20
                            duration: 2500
                            easing.type: Easing.InOutSine
                        }
                    }

                }
    }
}
