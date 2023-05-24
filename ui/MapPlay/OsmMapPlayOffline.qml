import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15
//2.14以下版本兼容性差
Item {
    id:root
    anchors.fill: parent

    Map {
        id: map
        anchors.fill: parent
        activeMapType: map.supportedMapTypes[1]
        plugin: Plugin {
            name: "osm"
            PluginParameter {
                name: 'osm.mapping.offline.directory'
                value: 'qrc:/ui/assets/tiles/osm_tiles/taihu_Tiles/'
            }
            PluginParameter {
                name: "osm.mapping.providersrepository.disabled"
                value: true
            }
        }
        center: QtPositioning.coordinate(120.23557514438828, 31.249212729199883) // Oslo
        zoomLevel: 12
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
            id:wheel
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

        Component.onCompleted: {
                 for( var i_type in supportedMapTypes ) {
                     if( supportedMapTypes[i_type].name.localeCompare( "Custom URL Map" ) === 0 ) {
                         activeMapType = supportedMapTypes[i_type]
                     }
                 }
             }
    }
}
