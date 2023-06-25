// Copyright (C) 2014 Klaralvdalens Datakonsult AB (KDAB).
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D
import QtQuick.Controls

Rectangle {

    id: vehiclePlay
    //坐标系 left-hand x-top y-right z-out
    property real x_tran: 0
    property real y_tran: 0
    property real z_tran: 0
    property real roll: 0
    property real pitch: 0
    property real yaw: 0
    property string title: "Front"
    property string bgColor: "#848895"

    width: parent.width
    height: 250
    visible: true

    // The root scene
    //! [rootnode]
    Node {
        id: standAloneScene
        //! [rootnode]

        DirectionalLight {
            ambientColor: Qt.rgba(0.5, 0.5, 0.5, 1.0)
            brightness: 1.0
            eulerRotation.x: -25
        }

        Model {
            source: "qrc:/ui/assets/3d/tow-boat/source/meshes/towBoat.mesh"
            y: -100
            scale: Qt.vector3d(50, 50, 50)
            materials: [
                PrincipledMaterial {
                    id: curtain_material
                    baseColorMap: Texture {
                        id: tilePatternTexture
                        source: "qrc:/ui/assets/3d/tow-boat/textures/Tow_Body_D.tga.png"
                        generateMipmaps: true
                        mipFilter: Texture.Linear
                    }
                    opacityChannel: Material.A
                    roughness: 0.5
                    normalMap: Texture {
                         id: curtainNormalTexture
                         source: "qrc:/ui/assets/3d/tow-boat/textures/Tow_Body_N.tga.png"
                         generateMipmaps: true
                         mipFilter: Texture.Linear
                     }
                     cullMode: Material.NoCulling
                     alphaMode: PrincipledMaterial.Opaque
                }
            ]
            //平移 This property contains the position translation in local coordinate space
            position: Qt.vector3d(x_tran, y_tran, z_tran)
            //旋转 This property contains the rotation values for the x, y, and z axis. These values are stored as a vector3d. Rotation order is assumed to be ZXY
            eulerRotation : Qt.vector3d(pitch, yaw, roll ) //ZYX旋转顺序

        }

        // Stationary orthographic camera viewing from the front
        OrthographicCamera {
            id: cameraOrthographicFront
            y: 50
            z: 600
        }
    }
    //! [cameras end]

    //! [views]
    // The views
    Rectangle {
        id: topLeft
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: parent.height
        color: bgColor
        border.color: bgColor

        View3D {
            id: topLeftView
            anchors.fill: parent
            importScene: standAloneScene
            camera: cameraOrthographicFront
        }

        Label {
            text: title
            anchors.top: parent.top
            anchors.left: parent.left
            color: "#222840"
            font.pointSize: 14
        }

//        Button{
//            //3d 模型随惯导数据旋转
//            id: button_auto
//            width: 100
//            height: 30
//            anchors{
//                top:parent.top
//                right:parent.right
//            }

//            text: qsTr("自动旋转")
////            color: "black"
////            background: "white"

//        }
//        Button{
//            //3d模型手动旋转
//            id: button_manual
//            width: 100
//            height: 30
//            anchors{
//                top: button_auto.bottom
//                right: parent.right
//            }

//            text: qsTr("手动旋转")
////            color: "black"
////            background: "orange"

//        }
    }
    //! [views]
}
