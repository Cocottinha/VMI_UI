import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
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
        // Rectangle {
        //             id: horizontalBar
        //             width: 400
        //             radius: 10
        //             height: 5 // Altura da barra
        //             color: "#222222" // Cor da barra (você pode mudar para qualquer cor ou usar um Gradiente)

        //             // Centralizada horizontalmente, e com o Y animado
        //             anchors.horizontalCenter: parent.horizontalCenter
        //             y: 0 // Posição base inicial
        //             layer.enabled: true
        //                         layer.effect: MultiEffect {
        //                             shadowEnabled: true      // Ativa a sombra
        //                             shadowColor: "#30000000" // Cor da sombra (com transparência)
        //                             shadowBlur: 0.5          // Suavidade/desfoque da sombra
        //                             shadowVerticalOffset: 6  // Deslocamento para baixo
        //                             shadowHorizontalOffset: 2
        //                         }
        //             // Animação contínua de subida e descida sem trancos
        //             SequentialAnimation {
        //                 running: true
        //                 loops: Animation.Infinite

        //                 NumberAnimation {
        //                     target: horizontalBar
        //                     property: "y"
        //                     from: -20    // Ponto mais alto que ela sobe
        //                     to: 390     // Ponto mais baixo que ela desce
        //                     duration: 2500
        //                     easing.type: Easing.InOutSine
        //                 }
        //                 NumberAnimation {
        //                     target: horizontalBar
        //                     property: "y"
        //                     from: 390
        //                     to: -20
        //                     duration: 2500
        //                     easing.type: Easing.InOutSine
        //                 }
        //             }

        //         }
        Shape {
                id: lightConeShape
                width: 400
                height: 450

                // Posição do Shape na tela
                x: 240
                y: 0

                // Método 2: Usando o componente Rotation para definir o eixo exato na ponta do triângulo
                transform: Rotation {
                    id: coneRotation
                    origin.x: 200  // Eixo X exato correspondente ao startX da ponta
                    origin.y: 0    // Eixo Y exato correspondente ao startY da ponta
                    angle: 45      // Ângulo inicial
                }

                data: ShapePath {
                    id: conePath
                    strokeWidth: 1
                    strokeColor: "transparent"

                    fillGradient: LinearGradient {
                        x1: 200; y1: 0
                        x2: 200; y2: 450

                        GradientStop { position: 0.0; color: "#A0FFFFE0" }
                        GradientStop { position: 0.5; color: "#50FFD700" }
                        GradientStop { position: 1.0; color: "#00FFD700" }
                    }

                    startX: 200; startY: 0
                    PathLine { x: 400; y: 450 }
                    PathLine { x: 0; y: 450 }
                    PathLine { x: 200; y: 0 }
                }

                // Animação simultânea: Balanço de pêndulo alterando o angle + Piscar (Opacidade)
                ParallelAnimation {
                    running: true
                    loops: Animation.Infinite

                    // 1. Movimento de Pêndulo alterando o 'angle' do componente Rotation
                    SequentialAnimation {
                        NumberAnimation {
                            target: coneRotation
                            property: "angle"
                            from: 35
                            to: 65
                            duration: 2000
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            target: coneRotation
                            property: "angle"
                            from: 65
                            to: 35
                            duration: 2000
                            easing.type: Easing.InOutSine
                        }
                    }

                    // 2. Efeito de Piscar (Fade In / Fade Out suave)
                    SequentialAnimation {
                        NumberAnimation {
                            target: lightConeShape
                            property: "opacity"
                            from: 0.6
                            to: 1.0
                            duration: 1000
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            target: lightConeShape
                            property: "opacity"
                            from: 1.0
                            to: 0.6
                            duration: 1000
                            easing.type: Easing.InOutSine
                        }
                    }
                }
            }
    }
}
