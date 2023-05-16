import QtQuick 2.12


Rectangle{
    //    汽车仪表盘
    id: carPlay
    width: 453
    height: 169
    color: "#000000"
    radius: 19
    anchors{
        left: parent.left
        top: parent.top
        right: parent.right
    }
    //    居中的速度仪表
    Rectangle{
        id: speedGauge
        width: 155
        height: 155
        radius: 155/2
        color: "white"
        anchors{
            centerIn: parent
        }

        CircleProgressBar{
            id: circleProgressBar
            anchors.centerIn: parent
            value: 0.3
            size: 150
        }
    }



}
