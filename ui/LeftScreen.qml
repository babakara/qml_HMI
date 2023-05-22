import QtQuick 2.0
import "qrc:/ui/CarPlay"
Rectangle{
    id: leftScreen
    width: 460
    anchors{
        left: parent.left
        top: parent.top
        bottom: bottomBar.top
    }
    color: "blue"

    CarPlay{
        id: carPlay
        anchors{
            left: parent.left
            top: parent.top
            right: parent.right
        }
    }
}
