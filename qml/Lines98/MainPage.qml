import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    Rectangle {
        id: background

        anchors.fill: parent
        color: "#343434"

        Image {
            source: "images/backgroudn1.jpg"
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
            opacity: 0.3
        }
    }
}
