import QtQuick 2.12
import QtQuick.Window 2.12

import "qrc:/ui"
//多层路径引用的问题 使用qrc方式比较稳定
//直接用/ui找不到
Window {
    width: 1280
    height: 768
    visible: true
    title: qsTr("Tesla Infotainment")
//    去掉标题栏
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint
//    右侧窗口
    RightScreen{
        id: rightScreen
    }
//    左侧窗口
    LeftScreen{
        id: leftScreen

        CarPlay{
            id: carPlay
        }
    }

//底边栏
    BottomBar{
        id:bottomBar
    }
}

