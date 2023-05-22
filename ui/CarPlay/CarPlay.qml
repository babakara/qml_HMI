import QtQuick 2.12

Rectangle{
    //    汽车仪表盘
    id: carPlay
//    width: 453
    height: 169
    color: "#000000"
    radius: 19

//        中间速度仪表盘
    CircleProgressBar{
        id: centerProgressBar
        anchors.centerIn: parent
        value: 0.3
        size: 150
        lineWidth: 10
    }

//  左边航向仪表盘
    HeadingProgressBar{
        id: headingProgressBar
        anchors{
            right: centerProgressBar.left
            rightMargin: 5
            top: centerProgressBar.top
//                topMargin: 15

        }
        value: 0.3
        secondaryColor: "#000000"
        size: 110
    }
//  左下角油表盘
    OilProgressBar{
        id: oilProgressBar
        anchors{
            left: parent.left
            leftMargin: 5
            bottom: parent.bottom
            bottomMargin: 5
        }
        size: 60
        value: 0.45
    }

    //右侧档位和转速盘
    GearProgressBar{
        id: gearProgressBar
        anchors{
            left: centerProgressBar.right
            leftMargin: 5
            top: centerProgressBar.top
        }
        value: 0.5
        size: 110
        lineWidth: 6
    }

//    右侧下方时间表
    TimeProgressBar{
        id: timeProgressBar
        anchors{
            right: parent.right
            rightMargin: 5
            bottom: parent.bottom
            bottomMargin: 5
        }

        size: 60
        value: {
            //获取系统的时间
            var hh_time = Qt.formatDateTime(new Date(), "hh")
            var mm_time = Qt.formatDateTime(new Date(), "mm")
            var hh_time_f = Number(hh_time)>12? (Number(hh_time)-12) : Number(hh_time)
            var hour = (hh_time_f + Number(mm_time)/60) / 12
//            console.log(hour)
            return hour
        }
        hh_value: Qt.formatDateTime(new Date(), "hh")
        mm_value: Qt.formatDateTime(new Date(), "mm")

    }

//    左侧中间靠下 冷却液水温仪表
    WaterTempProgressBar{
        id: waterTempProgressBar
        anchors{
            bottom: parent.bottom
            bottomMargin: 5
            right: centerProgressBar.left
//            rightMargin: 5
        }
        size: 46
        value: 0.4
    }

//    右侧中间靠下 发动机油压
    OilPressureProgressBar{
        id: oilPressProgressBar
        anchors{
            bottom: parent.bottom
            bottomMargin: 5
            left: centerProgressBar.right
        }
        size: 46
        value: 0.4
    }
}
