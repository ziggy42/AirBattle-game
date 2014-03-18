import QtQuick 2.1
import "logic.js" as Logic

Item {
    id: root
    height: parent.squareSize; width: parent.squareSize
    y: 0; x: Logic.getX(col)

    property int col
    property bool dead: false
    property alias speed: numAnimation.duration
    property alias run: animation.running

    function die() {
        dead = true
        image.source = "../images/explosion1.png"
        animation.running = false
        root.x = root.x + (image.width - image.width*1.1)
        parallel.running = true
        destroy(1000)
        return true
    }

    /*Component.onCompleted: {
        waiter.interval = (Math.random()*2000)
        waiter.running = true
    }*/

    Image {
        id: image
        width: parent.width; height: parent.height
        anchors.fill: parent
        smooth:true
        source: "../images/F16-enemy.png"

        ParallelAnimation {
            id: parallel
            running: false
            //NumberAnimation {target: root; property: "x"; duration: 1; to: root.x + (image.width - image.width*1.1)}
            NumberAnimation { target: root; property: "height"; duration: 400;  to: image.height*1.1}
            NumberAnimation { target: root; property: "width"; duration: 400;  to: image.width*1.1 }
        }
    }

    SequentialAnimation on y {
        id: animation
        running: true
        NumberAnimation {
            id: numAnimation
            to: parent.height//500
            duration: Logic.enemySpeed//25000
        }
        ScriptAction {
            script: {
                animation.running = false
                Logic.kill2(root.x,root.y)
                Logic.injuried()
            }
        }
    }

   Repeater {
        id: shootsBack
        model: ListModel { id: shootModel }
        delegate: Image {
            id: shoots
            source: "../images/missile_enemy.svg"
            width: parent.width*0.5; height: parent.height*0.7
            anchors.horizontalCenter: parent.horizontalCenter

            SequentialAnimation on y {
                id: sparo

                NumberAnimation {
                    to: 1000
                    duration: 2000
                }
            }

        }
   }

   /*Timer {
       id: timer
       interval: 2000
       running: false//true
       repeat: true
       onTriggered: if(!dead) shootModel.append({})
       //triggeredOnStart: true

   }

   Timer {
       id: waiter
       repeat: false
       running: false

       onTriggered: timer.running = true
   }*/
}
