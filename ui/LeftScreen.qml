import QtQuick 2.0

Rectangle{
    id: leftScreen
    anchors{
        left: parent.left
        top: parent.top
        bottom: bottomBar.top
        right: rightScreen.left
    }
    color: "blue"
}
