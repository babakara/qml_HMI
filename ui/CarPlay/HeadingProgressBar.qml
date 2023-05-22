import QtQuick 2.12

Item {
    id: root
    property int size: 150
    property real lineWidth: 1
//    value 的比例
    property real value: 0
//    仪表最大值
    property int maxValue: 55
    property string unit_a: " km/h" //小字的单位
    property string unit_b: " knot" //大字的单位

    property color primaryColor: "#9cb192"//背景底色
    property color secondaryColor: "#000000" //刻度的颜色

    property int animationDuration: 1000

    width: size
    height: size
    //最大的进度条范围
    onValueChanged: {
        canvasTriangle.degree = value * 360;
    }

//    外圈白边
    Rectangle{
        id: speedGauge
        width: size*1.03
        height: size*1.03
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
        color: primaryColor
    }

    Rectangle{
        id:backCircleOutter
        width:backCircle.width-size*0.2
        height:backCircle.height-size*0.2
        radius: width/2
        anchors{
            centerIn: parent
        }

        color: "#434c3e"
    }

    Rectangle{
        id:backCircleInner
        width:backCircle.width-size*0.3
        height:backCircle.height-size*0.3
        radius: width/2
        anchors{
            centerIn: parent
        }

        color: "#000000"
    }

    Canvas{
        id:canvas

        anchors.fill: parent
        antialiasing: true

        onPaint: {
            var ctx = getContext("2d")

            var x = root.width/2
            var y = root.height/2
            var radius = root.size/2 - root.lineWidth
            ctx.reset()

            ctx.lineWidth = lineWidth;

//            移动到新的原点
            ctx.translate(x,y)
//            开始绘图
            ctx.beginPath()
//            循环绘制小刻度
            var stepAngle = 5
            var bigStepAngle = 90
            for(let i=0;i<361;i+=stepAngle){
//                移动画笔
                ctx.moveTo(0,radius)
//                画下小刻度
//                i%90? ctx.lineTo(0,radius-size*0.03) : ctx.lineTo(0,radius-size*0.06)
                if (i%90){
                    ctx.lineTo(0,radius-size*0.03)

                }else{
                    ctx.lineTo(0,radius-size*0.06)
//                写下数字
//                    ctx.fillText(i,0,radius-size*0.03)
                }
//                旋转画笔
                ctx.rotate(stepAngle* Math.PI/180.0)
            }

            ctx.strokeStyle = root.secondaryColor
            ctx.stroke()
        }
    }


    Text {
        id: speedNumber
        text: canvasTriangle.degree + qsTr("°")
        color: "white"
        anchors{
            top:canvas.top
            topMargin: 3.5*size/10
            horizontalCenter: canvas.horizontalCenter

        }
        font.pixelSize: 18
        font.bold: true
    }

    Text{
        id: symbol
        text: qsTr("NW")
        color: "white"
        anchors{
            horizontalCenter: canvas.horizontalCenter
            top:speedNumber.bottom
        }
        font.pixelSize: 10
        font.bold: false
    }


//    刷新绘制一对三角形指针 填充颜色
    Canvas{
        id:canvasTriangle

        property real degree: 0

        anchors.fill: parent
        antialiasing: true

        onDegreeChanged: {
            requestPaint();
        }
        onPaint: {
            var ctx = getContext("2d");
            var margin = size*0.3;
            var x = root.width/2;
            var y = root.height/2;
            var radius = root.size/2 - root.lineWidth
            ctx.reset()

            ctx.lineWidth = lineWidth

//            移动到新的原点
            ctx.translate(x,y)
//            坐标系旋转 等效箭头旋转
            ctx.rotate(degree * Math.PI/180)
//            开始绘图
            ctx.beginPath()
            ctx.moveTo(0, (backCircle.height-margin)/2)
            ctx.lineTo(-3, (backCircle.height-margin)/2 - size*0.1)
            ctx.lineTo(3, (backCircle.height-margin)/2 - size*0.1)
            ctx.lineTo(0, (backCircle.height-margin)/2)
            ctx.fillStyle = "#ffffff"
            ctx.closePath();
            ctx.fill()
            ctx.stroke()

            ctx.beginPath()
            ctx.moveTo(0, -(backCircle.height-margin)/2)
            ctx.lineTo(-3, -(backCircle.height-margin)/2 + size*0.1)
            ctx.lineTo(3, -(backCircle.height-margin)/2 + size*0.1)
            ctx.lineTo(0, -(backCircle.height-margin)/2)
            ctx.fillStyle = "#eb612a"
            ctx.fill()
            ctx.stroke()
        }

        Behavior on degree {
            NumberAnimation {
                duration: root.animationDuration
            }
        }
    }
}
