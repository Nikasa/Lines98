// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

MainPage {
    id: mainpage1
    Column {
        id: grid
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Text {
            id: text1
            color: "#ffffff"
            text: qsTr("New game")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                id: mouse_area1
                anchors.fill: parent
            }
        }

        Text {
            id: text2
            color: "#ffffff"
            text: qsTr("Continue")
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                id: mouse_area2
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: text3
            color: "#ffffff"
            text: qsTr("High scores")
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                id: mouse_area3
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: text4
            color: "#ffffff"
            text: qsTr("Options")
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                id: mouse_area4
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: text5
            color: "#ffffff"
            text: qsTr("Help")
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                id: mouse_area5
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

}
