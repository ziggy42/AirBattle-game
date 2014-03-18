import QtQuick 2.0

Item {
    id: container

    property string buttonName: "NOT SET"
    property string target: "NOT SET"
    property string text: ""
    property string fontName: "Helvetica"
    property int fontSize: 15
    property color fontColor: "#AC9D93"

    property bool active: false
    property string bgImage: "../images/button.png"
    property string bgImagePressed: "../images/button_pressed.png"
    property string bgImageActive: bgImagePressed

    signal clicked(string target, string button)

    width: parent.width
    height: 70

    opacity: enabled ? 1.0 : 0.5

    Image {
        id: background
        source: bgImage;
        anchors.fill: parent
        smooth: true
    }

    Text {
        anchors {
            centerIn: background
            margins: 10
        }
        font {
            family: container.fontName
            pointSize: container.fontSize
        }
        color: container.fontColor
        text: container.text
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: container.clicked(container.target, container.buttonName);
    }

    states: [
        State {
            name: 'pressed'; when: mouseArea.pressed
            PropertyChanges { target: background; source: bgImagePressed; }
        },
        State {
            name: 'active'; when: container.active
            PropertyChanges { target: background; source: bgImageActive; }
        }
    ]

}
