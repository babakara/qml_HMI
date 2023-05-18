import QtQuick 2.0

Item {
    id: root

    property int size: 150
    property int lineWidth: 5
//    value 的比例0-1
    property real hh_value: 0
    property real mm_value: 0
    property real value: 0
//    仪表最大值
    property int maxValue: 12 //24小时

    property color primaryColor: "#76fb6a"
    property color secondaryColor: "#327343"

    property int animationDuration: 1000

    width: size
    height: size
    //最大的进度条范围
    onValueChanged: {
        canvas.degree = value * 360;
    }

//白色外圈
    Rectangle{
        id: speedGauge
        width: size*1.04
        height: size*1.04
        radius: width/2
        color: "white"
        anchors{
            centerIn: parent
        }
    }
//    背景底色
    Rectangle{
        id:backCircle
        radius: root.width/2
        anchors.fill: parent
        color: "#152d29"

    }

    Canvas {
        id: canvas

        property real degree: 0

        anchors.fill: parent
        antialiasing: true

        onDegreeChanged: {
            requestPaint();
        }

        onPaint: {
            var ctx = getContext("2d");

            var x = root.width/2;
            var y = root.height/2;

            var radius = root.size/2 - root.lineWidth
//            背景进度
            var backStartAngle = (Math.PI/180) * (270);
            var backEndAngle = (Math.PI/180) * (270 + 360);
//            前景进度
            var startAngle = (Math.PI/180) * (270);
            var progressAngle = (Math.PI/180) * (270 + degree);

            ctx.reset()

            ctx.lineCap = 'round';
            ctx.lineWidth = root.lineWidth;

            ctx.beginPath();
            ctx.arc(x, y, radius, backStartAngle, backEndAngle, false);//false是顺时针绘制
            ctx.strokeStyle = root.secondaryColor;
            ctx.stroke();

            ctx.beginPath();
            ctx.arc(x, y, radius, startAngle, progressAngle, false);
            ctx.strokeStyle = root.primaryColor;
            ctx.stroke();

        }

        Behavior on degree {
            NumberAnimation {
                duration: root.animationDuration
            }
        }
    }

    property string time_symbol: "AM"

    Text {
        id: timeNumber
        text: {
            //12小时制的时间转换

            var hh_time = 0
            if(hh_value > 12){
                hh_time = hh_value - 12
                time_symbol = "PM"
            }else{
                hh_time = hh_value
            }
            return hh_time + ":" + mm_value
        }
        color: "white"
        anchors.centerIn: parent
        font.pixelSize: size*0.20
        font.bold: true
    }

    Text {
        id: timeSymbol
        text: qsTr(time_symbol)
        color: "white"
        anchors{
            horizontalCenter: timeNumber.horizontalCenter
            top: timeNumber.bottom
        }
        font.pixelSize: size*0.15
        font.bold: true
    }

}
