import QtQuick 2.1
import QtQuick.Particles 2.0
import "logic.js" as Logic

Item {
    id: root
    height: parent.squareSize; width: parent.squareSize
    y: 0; x: Logic.getX(col)

    property int col
    property bool dead: false
    property alias speed: numAnimation.duration
    property alias run: animation.running
    property int life: 1

    function die() {
        if(life === 0) {
            dead = true
            image.source = "../images/explosion1.png"
            animation.running = false
            root.x = root.x + (image.width - image.width*1.1)
            parallel.running = true
            emitter.emitRate = 0
            destroy(1000)
            Logic.gameState.score ++;
            return true
        }
        else {
            life--;
            particlesItem.running = true
            return false
        }
    }

    Image {
        id: image
        width: parent.width; height: parent.height
        anchors.fill: parent
        smooth:true
        source: "../images/enemy2.png"

        ParallelAnimation {
            id: parallel
            running: false
            NumberAnimation { target: root; property: "height"; duration: 400;  to: image.height*1.1}
            NumberAnimation { target: root; property: "width"; duration: 400;  to: image.width*1.1 }
        }
    }

    SequentialAnimation on y {
        id: animation
        running: true
        NumberAnimation {
            id: numAnimation
            to: parent.height - 3*image.height
            duration: Logic.enemySpeed//25000
        }
        ScriptAction {
            script: {
                animation.running = false
                Logic.kill2(root.x)
                //Logic.injuried()
            }
        }
    }

    ParticleSystem {
         id: particlesItem
         running: false
         anchors.centerIn: parent

         ImageParticle {
             source: "../images/particle.png"
             rotationVariation: 180
             color:"gray"
             colorVariation: 0.1
         }

         Emitter {
             id: emitter
             anchors.centerIn: parent
             emitRate: 500//1000
             lifeSpan: 1000//3500
             size: 2
             sizeVariation: 24
             velocity: PointDirection{ y: -200; yVariation: x*0.5; xVariation: 30 }
             endSize: 1

         }
     }
}
