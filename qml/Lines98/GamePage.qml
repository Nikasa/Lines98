import QtQuick 1.1
import com.nokia.symbian 1.1
import "core" 1.0
import "core/lines.js" as Logic

MainPage {
    id: gamePage
    //anchors.fill: parent
    property int margin: 10
    Rectangle{
        id: controlBar
        height: 100
        opacity: 1
        visible: true
        width: parent.width
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        Rectangle{
            id: scoreBoard
            height: controlBar.height
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.leftMargin: margin
            Text{
                id: scoreText
                property int score: 0
                text: "Score " + score
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle{
            id: ballBoard
            anchors.right: parent.right
            anchors.rightMargin: margin
            anchors.verticalCenter: parent.verticalCenter
            Text{
                property int ball: 0
                text: "Balls " + ball
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    MouseArea{

        height: gameGrid.height
        width: gameGrid.width
        anchors {verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter}


        Grid{
            id: gameGrid
            property int score: 0
            property int blockSize: 50
            property int numClicked: 0
            onScoreChanged:scoreText.score = score
            columns: 9
            spacing: 0

            Repeater{
                id: repeatTile
                model: 81
                delegate: Tile{ }
            }
        }
        onClicked: Logic.handleClick(mouse.x,mouse.y)
    }

    Dialog { id: dialog; anchors.centerIn: parent; z: 21 }

    Dialog {
        id: nameInputDialog

        property int initialWidth: 0
        property alias name: nameInputText.text

        anchors.centerIn: parent
        z: 22;

        Behavior on width {
            NumberAnimation {}
            enabled: nameInputDialog.initialWidth != 0
        }

        onClosed: {
            if (nameInputText.text != "")
                Logic.saveHighScore(nameInputText.text);
        }
        Text {
            id: dialogText
            anchors { left: nameInputDialog.left; leftMargin: 20; verticalCenter: parent.verticalCenter }
            text: "You won! Please enter your name: "
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (nameInputText.text == "")
                    nameInputText.openSoftwareInputPanel();
                else
                    nameInputDialog.forceClose();
            }
        }

        TextInput {
            id: nameInputText
            anchors { verticalCenter: parent.verticalCenter; left: dialogText.right }
            focus: visible
            autoScroll: false
            maximumLength: 24
            onTextChanged: {
                var newWidth = nameInputText.width + dialogText.width + 40;
                if ( (newWidth > nameInputDialog.width && newWidth < screen.width)
                        || (nameInputDialog.width > nameInputDialog.initialWidth) )
                    nameInputDialog.width = newWidth;
            }
            onAccepted: {
                nameInputDialog.forceClose();
            }
        }
    }
    Component.onCompleted: Logic.startNewGame()
}
