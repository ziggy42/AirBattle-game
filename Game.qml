import QtQuick 2.1
import "components"
import "components/logic.js" as Logic

Item {
    property alias run: grid.upRunning
    property bool gameIsStarted: false

    onRunChanged: {
        if(run) {
            Logic.newGame(grid);
        }
    }

    Item {
        width: parent.width - 40
        y: parent.height * 0.6
        anchors {horizontalCenter: parent.horizontalCenter;}

        Image {
            width: parent.width/7; height: parent.width/7
            source: "./images/ball.png"
            anchors { left: parent.left }

            Text {
                anchors {centerIn: parent}
                font.pixelSize:  parent.width * 0.75
                text: grid.lives
            }
        }
        Image {
            width: parent.width/7; height: parent.width/7
            clip: true
            source: "./images/ball.png"
            anchors { right: parent.right }

            Text {
                anchors {centerIn: parent}
                font.pixelSize:  parent.width * 0.75
                text: grid.score
            }
        }
    }

    Grid {
        id: grid
    }
}
