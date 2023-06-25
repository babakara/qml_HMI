import QtQuick 2.2
import "qrc:/ui/CarPlay"
import "qrc:/ui/3DPlay"
import QtQuick.Scene3D 2.2
import QtQuick3D 2.2
import QtQuick.Controls 2.2

Rectangle{
    id: leftScreen
    width: 460
    anchors{
        left: parent.left
        top: parent.top
        bottom: bottomBar.top
    }
    color: "#447b8c"

    CarPlay{
        id: carPlay
        anchors{
            left: parent.left
            top: parent.top
            right: parent.right
        }
    }

    VehiclePlay{
        id: vehiclePlay
        bgColor: parent.color
        title: "Speed-Boat"
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: carPlay.bottom
        }

        x:0
        y:0
        z:0
        roll: 0
        pitch: 0
        yaw: 70

        MouseArea{
            //捕获光标
            //左键按下可以旋转模型
            property real init_x: parent.x + parent.width*0.5
            property real init_y: parent.y + parent.height*0.5
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            cursorShape: Qt.OpenHandCursor
            onPositionChanged: {
                var delta_x = mouseX - init_x
//                var delta_y = mouseY - init_y
                parent.yaw = parent.yaw + delta_x/parent.width * 5
//                parent.pitch = parent.pitch - delta_y/parent.height * 2
//                console.log("angle is :" + parent.yaw)
            }
        }
    }

    //人工操纵面板
    Rectangle{
        id: control_panel
        anchors{
            top: vehiclePlay.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        color: "orange"

        Image{
            id: boat_img
            anchors.centerIn: parent
            width: parent.width *0.8
            fillMode: Image.PreserveAspectFit
            source:"qrc:/ui/assets/3d/boat.jpeg"
        }
    }

}
