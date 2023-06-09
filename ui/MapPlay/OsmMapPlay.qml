import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15
Item {
    id:root
    anchors.fill: parent

    Plugin {
        id: mapPlugin
        name: "osm" // "osm", "mapboxgl", "esri", ...

    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(59.91, 10.75) // Oslo
        zoomLevel: maximumZoomLevel - 4
        property geoCoordinate startCentroid

        PinchHandler{
            id: pinch
            target: null
            onActiveChanged: if (active){
                                 map.startCentorid = map.toCoordinate(pinch.centroid.position, false)
                             }
            onScaleChanged: (delta) => {
                                map.zoomLevel += Math.log2(delta)
                                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                            }
            onRotationChanged: (delta) => {
                                   map.bearing -= delta
                                   map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                               }
            grabPermissions: PointerHandler.TakeOverForbidden

        }
        WheelHandler{
            id:wheel_id
            rotationScale: 1/120
            property: "zoomLevel"
        }
        DragHandler{
            id:drag
            target: null
            onTranslationChanged: (delta) => {
                                      map.pan(-delta.x, -delta.y)
                                  }
        }
        Shortcut{
            enabled: map.zoomLevel < map.maximumZoomLevel
            sequence: StandardKey.ZoomIn
            onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
        }
    }
}
