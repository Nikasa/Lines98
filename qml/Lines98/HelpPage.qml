import QtQuick 1.1
import com.nokia.symbian 1.1

MainPage{
    Flickable{
        id: flickText
        width: parent.width
        height: parent.height
        Text{
            id: helpText
            color:"white"
            width: parent.width
            height: parent.height - sharedToolBar.height
            text: "Text items can display both plain and rich text. For example, red text with a specific font and size can be defined like this: <b>Hello</b> <i>World!</i>
Set this property to wrap the text to the Text item's width. The text will only wrap if an explicit width has been set. wrapMode can be one of: Text.NoWrap (default) - no wrapping will be performed.
dsadas jdhahs gfd  rewe 3 2  vcxvx ewrew"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 0
            wrapMode: Text.Wrap
        }
    }
    //    Button{
    //        //            anchors.verticalCenter: parent
    //        //            anchors.horizontalCenter: parent
    //        text: "Thanks"
    //        anchors.horizontalCenter: parent.horizontalCenter
    //        anchors.verticalCenter: parent.verticalCenter
    //       // onClicked: pageStack.push(Qt.resolvedUrl("MenuPage.qml"))
    //    }

    ScrollBar {
        flickableItem: flickText
        anchors { right: flickText.right; top: flickText.top}
        opacity: 0

    }
}
