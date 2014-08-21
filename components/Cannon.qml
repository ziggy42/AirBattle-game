import QtQuick 2.1

Image {
    id: root
    focus: true

    property alias mAreaDrag: mArea.drag

    MouseArea {
        id: mArea
        anchors {fill: parent}

        drag {
            target: root
            axis: Drag.XAxis
        }

        onClicked: repeaterModel.append({"xvar": xvalue + cannon.width/2 - cannon.width/22})
    }
}

