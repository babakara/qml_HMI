import QtQuick 2.0
import QtLocation 5.12
import QtPositioning 5.12
Rectangle{
    id: rightScreen
    anchors{
        top: parent.top
        bottom: bottomBar.top
        right: parent.right
    }
    width: parent.width * 2/3
    color: "orange"

    visible: true

//    Plugin {
//        id: mapPlugin
//        name: "osm" // "osm", "mapboxgl", "esri", ...
//        // specify plugin parameters if necessary
//        // PluginParameter {
//        //     name:
//        //     value:
//        // }
//    }

//    Map {
//        anchors.fill: parent
//        plugin: mapPlugin
//        center: QtPositioning.coordinate(59.91, 10.75) // Oslo
//        zoomLevel: 14
//    }
}
