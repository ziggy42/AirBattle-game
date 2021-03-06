import QtQuick 2.1
import "logic.js" as Logic

Item {
    id: root

    property int cols: 8
    property int squareSize: parent.width/cols
    property Item grid: root
    property int score: 0
    property alias upInterval: updater.interval
    property alias run: updater.running
    property int xvalue : cannon.x

    Keys.onPressed: {
        if ((event.key === Qt.Key_Left) && (cannon.x >= 0 - cannon.width/3))
            cannon.x -=  20

        if ((event.key === Qt.Key_Right) && (cannon.x < root.width - cannon.width*2/3))
            cannon.x += 20

        if (event.key === Qt.Key_Space)
            repeaterModel.append({"xvar": xvalue + cannon.width/2 - cannon.width/22})
    }

    onRunChanged: if(run) Logic.newGame(grid)

    Text {
        id: scoreText
        anchors {centerIn: parent}
        font.pixelSize: parent.height/6
        color: "white"
        text: grid.score
    }

    Timer {
        id: updater
        interval: 2000
        running: false
        repeat: true
        onTriggered: Logic.up();
    }

    Cannon {
        id: cannon
        source: "../images/f-16.png"
        width: parent.width/4
        height: parent.height/6
        anchors { bottomMargin: 5; bottom: parent.bottom; }
        mAreaDrag {minimumX: 0 - width/3; maximumX: root.width - width*2/3 }
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

                onStarted: numberAnimation.duration = (Logic.setTarget(bullet.x)/speed)

                NumberAnimation {
                    id: numberAnimation
                    property double space: Logic.setTarget(bullet.x)

                    to: space
                }
                ScriptAction {
                    script: {
                        if(numberAnimation.to !== 0) Logic.kill(bullet.x)
                        repeaterModel.remove(0)
                    }
                }
            }
        }
    }
}
