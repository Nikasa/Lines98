import QtQuick 1.1
import com.nokia.symbian 1.1

Window {
    id: window

    PageStack{
        id:pageStack
        initialPage: menuPage
        toolBar: sharedToolBar
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: sharedToolBar.top
        }
    }

    StatusBar {
        id: statusBar

        anchors { top: parent.top; left: parent.left; right: parent.right }
    }

    ToolBar {
        id: sharedToolBar

        anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
    }


    MenuPage{
        id: menuPage
        anchors { fill: parent; topMargin: statusBar.height; bottomMargin: sharedToolBar.height }
        tools:ToolBarLayout{
            ToolButton{
                iconSource:  "toolbar-back"
                onClicked: Qt.quit();
            }
        }
    }

//    Men{
//        id: menuPage
//        anchors { fill: parent; topMargin: statusBar.height; bottomMargin: sharedToolBar.height }
//        tools:ToolBarLayout{
//            ToolButton{
//                iconSource:  "toolbar-back"
//                onClicked: Qt.quit();
//            }
//        }
//    }

    GamePage{
        id: gamePage
        anchors { fill: parent; topMargin: statusBar.height; bottomMargin: sharedToolBar.height }
        tools:ToolBarLayout{
            ToolButton{
                iconSource:  "toolbar-back"
                onClicked: pageStack.replace(menuPage);
            }
        }
    }

    HelpPage{
        id:helpPage
        anchors { fill: parent; topMargin: statusBar.height; bottomMargin: sharedToolBar.height }
        tools:ToolBarLayout{
            ToolButton{
                //text:"back"
                iconSource:  "toolbar-back"
                onClicked: pageStack.replace(menuPage);
            }
        }
    }
}


