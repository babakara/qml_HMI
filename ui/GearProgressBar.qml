import QtQuick 2.12

Item {
    id: root

    property int size: 150
    property int lineWidth: 5
//    value 的比例
    property real value: 0
    property string gear: "D" //档位
//    仪表最大值
    property int maxValue: 8000 //最大转速
    property string unit_a: " rpm" //转速单位

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

            //js线性渐变
            var grd = ctx.createLinearGradient(0,0,size*1.5,size);
            grd.addColorStop(0,'#72F5EC');
            grd.addColorStop(0.25,'#705F1B');
            grd.addColorStop(0.7,'#682D12');
            grd.addColorStop(1,'#661411');

            ctx.lineCap = 'round';
            ctx.lineWidth = root.lineWidth;

            ctx.beginPath();
            ctx.arc(x, y, radius, backStartAngle, backEndAngle, false);//false是顺时针绘制
            ctx.strokeStyle = grd;
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
//显示档位
    Text {
        id: speedNumber
        text: qsTr(gear)
        color: "white"
        anchors{
            horizontalCenter: canvas.horizontalCenter
            top: canvas.top
            topMargin: size*0.3
        }
        font.pixelSize: size*0.25
        font.bold: true
    }
//    显示档位提示
    Text{
        id: symbol
        text: qsTr("档位")
        color: "white"
        anchors{
            horizontalCenter: speedNumber.horizontalCenter
            top: speedNumber.bottom
        }
        font.pixelSize: size*0.1
        font.bold: false
    }

//显示转速
    Text{
        id: kmSymbol
        text: value2speed(value) + unit_a
        color: "#ffffff"
        anchors{
            horizontalCenter: symbol.horizontalCenter
            top: symbol.bottom
            topMargin: size*0.05
        }
        font.pixelSize: size*0.1
        font.bold: false
    }

}
