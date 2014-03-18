import QtQuick 2.1
import QtMultimedia 5.0

Item {
    id: root

    property int bombs: 3

    property alias cannonWidth: root.width
    property alias cannonHeight: root.height
    property alias cannonImage: cannonImage.source

    Image {
        id: cannonImage
        smooth: true
        anchors {fill: parent }
        focus: true
    }

    MouseArea {
        anchors {fill: parent}
        drag.target: root
        drag.axis: Drag.XAxis

       onClicked: {
           repeaterModel.append({"xvar": xvalue + cannon.width/2 - cannon.width/22})
           //projSound.play() meglio di no
        }
    }

    SoundEffect {
        id: projSound
        source: "../sounds/Harpoon.wav"
    }
}

