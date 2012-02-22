import QtQuick 1.1
import com.nokia.symbian 1.1
//import "core/lines.js" as Logic

MainPage {
    Column{
        id: grid
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

        Text{
            width: 100
            height:50
            color: "white"
            text: "New game"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    pageStack.replace(gamePage)
                }
            }
        }

        Text{
            width: 100
            height:50
            color: "white"
            text: "Continue"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            //anchors.horizontalCenter: parent.horizontalCenter
        }

        Text{ width: 100
            height:50
            color: "white"
            text: "High scores"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            //anchors.horizontalCenter: parent.horizontalCenter
        }

        Text{
            width: 100
            height:50
            color: "white"
            text: "Options"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            //anchors.horizontalCenter: parent.horizontalCenter
        }


        Text{
            width: 100
            height:50
            color: "white"
            //anchors.verticalCenter: parent
            //anchors.horizontalCenter: parent
            text: "Help"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            //anchors.horizontalCenter: parent.horizontalCenter
            MouseArea{
                anchors.fill: parent
                onClicked: pageStack.replace(helpPage)
            }
        }

    }

}


