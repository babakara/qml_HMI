import QtQuick 2.0

Item {
    id: root

    property int size: 150
    property int lineWidth: 5
//    value 的比例0-1
    property real value: 0
    property real distance: 207
//    仪表最大值
    property int maxValue: 100
    property string unit_a: " km/h" //小字的单位
    property string unit_b: " knot" //大字的单位

    property color primaryColor: "#76fb6a"
    property color secondaryColor: "#327343"

    property int animationDuration: 1000

    width: size
    height: size
    //最大的进度条范围
    onValueChanged: {
        canvas.degree = value * 270;
    }

//    仪表数值修改
    function value2speed(val){
//        反馈速度 单位：knot
        return val*maxValue
    }

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
            var backStartAngle = (Math.PI/180) * (90 + 45);
            var backEndAngle = (Math.PI/180) * (90 + 45 + 270);
//            前景进度
            var startAngle = (Math.PI/180) * (90+45);
            var progressAngle = (Math.PI/180) * (90 + 45 + degree);

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


    Text {
        id: oilNumber
        text: Math.floor(value2speed(value)) + "%"
        color: "white"
        anchors{
            horizontalCenter: canvas.horizontalCenter
            top: canvas.top
            topMargin: size*0.3
        }
        font.pixelSize: size*0.22
        font.bold: true
    }

    Image{
        id:oilImg
        width: 20
        height: 20
        anchors{
            horizontalCenter: oilNumber.horizontalCenter
            top: oilNumber.bottom
        }
        source: "qrc:/ui/assets/oil.svg"
    }

}
