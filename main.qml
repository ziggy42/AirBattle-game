import QtQuick 2.1
import "components"
import "controls"
import "components/logic.js" as Logic

Rectangle {
    id: grandeCapo
    height: 700
    width: 400

    Rectangle {
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#89d4ff" }
            GradientStop { position: 1.0; color: "#f3fbff" }
        }

        Cloud { id: cloud1; sourceImage: "../images/cloud1.png"}
        Cloud { id: cloud2; sourceImage: "../images/cloud1.png"}
        Cloud { id: cloud3; sourceImage: "../images/cloud1.png"}
        Cloud { id: cloud4; sourceImage: "../images/cloud2.png"}
        Cloud { id: cloud5; sourceImage: "../images/cloud2.png"}
        Cloud { id: cloud6; sourceImage: "../images/cloud2.png"}

    }

    ControlsWidget {
        id: starterWindow
        width: parent.width * 0.75
        height: childrenRect.height
        y: parent.height/2 - height/2

        anchors {
            horizontalCenter: parent.horizontalCenter
        }

        onStartGameChanged: {
            if(startGame === true) {
                game.run = true
                game.visible = true
                goAwayControlsWidgetAnimation.running = true
            }
        }

        SequentialAnimation on y {
            id: goAwayControlsWidgetAnimation
            running: false

            NumberAnimation {
                id: numberAnimation
                to: -10 - starterWindow.height
                duration: 500
            }
            ScriptAction {
                script: {
                    goAwayControlsWidgetAnimation.running = false
                    starterWindow.destroy()
                }
            }
        }
    }

    Game {
        id: game
        visible: false

        onRunChanged: {
            if(run === false) {
                game.destroy()
            }
        }

        Component.onDestruction: {
            /* Qt.createComponent("Game.qml")
                Continua seguendo http://qt-project.org/doc/qt-4.8/qdeclarativedynamicobjects.html
            */
        }
    }
}


