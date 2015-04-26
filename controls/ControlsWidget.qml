import QtQuick 2.1

Item {
    property bool startGame: false

    Column {
        width: parent.width
        spacing: 10

        Button {
            id: starterButton
            width: parent.width
            text: "Start Game"

            onClicked: startGame = true
        }

        Button {
            text: "Rate this game"
            width: parent.width
            onClicked: {
                switch(Qt.platform.os) {
                    case 'android':
                        Qt.openUrlExternally("market://details?id=com.andreapivetta.airbattle")
                        break
                    default:
                        console.log("Platform not supported")
                }
            }
        }

        Button {
            text: "Exit"
            width: parent.width
            onClicked: Qt.quit()
        }
    }

}
