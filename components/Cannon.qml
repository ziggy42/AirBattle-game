import QtQuick 2.1

Item {
    id: root

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
        }
    }
}

