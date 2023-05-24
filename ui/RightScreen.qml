import QtQuick 2.0
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
//    OsmMapPlay{
//        id: osmMapPlay
//    }
    OsmMapPlayOffline{
        id: osmMapPlayOffline
    }

}
