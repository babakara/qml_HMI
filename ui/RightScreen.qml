import QtQuick 2.5
import "qrc:/ui/MapPlay"
Rectangle{
    id: rightScreen
    anchors{
        top: parent.top
        bottom: bottomBar.top
        right: parent.right
        left: leftScreen.right
    }
    color: "orange"

    visible: true
    //在线版本
    OsmMapPlay{
        id: osmMapPlay
    }
//    OsmMapPlayOffline{
//        id: osmMapPlayOffline
//    }

}
