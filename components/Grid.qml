import QtQuick 2.1
import QtMultimedia 5.0
import "logic.js" as Logic

Item {
    id: root

    // PROPRIETÀ DELLA GRIGLIA STESSA

    property int squareSize: parent.width/8 // lato dei quadrati dentro la griglia
    property int cols: 8      // numero di colonne della griglia
    property Item grid: root    // si riferisce all'oggetto stesso

    // PROPRIETÀ DEL GIUOCO - PARTE UP
    property int score: 0       // punteggio corrente
    property int lives: 3       // vite rimaste - numero di volte in cui sei stato colpito

    property alias upInterval: updater.interval
    property alias upRunning: updater.running

    //property alias explosionSound: explosion.muted UNSUPPORTED
    //property alias cannonSound: cannon.missileSound UNSUPPORTED
    property int xvalue : cannon.x

    width: parent.width
    height: parent.height

    onScoreChanged: {
        //if(score%20 === 0) Logic.levelUp()
        //explosion.play() meglio di no
    }

    function restore() {
        lives = 3
        score = 0
    }

    Timer {
        id: updater
        interval: 2000
        running: false
        repeat: true
        onTriggered: Logic.up();
    }

    SoundEffect {
        id: explosion
        source: "../sounds/Grenade.wav"
    }

    Cannon {
        id: cannon
        cannonImage: "../images/f-16.png"
        cannonWidth: parent.width/4; cannonHeight: parent.height/6
        anchors { bottomMargin: 5; bottom: parent.bottom; }
    }

    Repeater {
        id: shoots
        focus: false
        model: ListModel { id: repeaterModel }
        delegate: Image {
            id: bullet
            y: cannon.y; x: xvar
            height: width*4; width: cannon.width/11
            source:  "../images/missile.png"

            SequentialAnimation on y {
                running: true
                property double speed : 0.51
                property double bersaglio

                onStarted: {
                    numberAnimation.duration = (Logic.setTarget(bullet.x)/speed)
                }

                NumberAnimation {
                    id: numberAnimation
                    property double space: Logic.setTarget(bullet.x)

                    to: space
                }
                ScriptAction {
                    script: {
                        if(numberAnimation.to !== 0) {
                            Logic.kill(bullet.x)
                        }

                        repeaterModel.remove(0)
                    }
                }
            }
        }
    }
}
