import QtQuick 2.12

Item {
    id: root

    property int size: 150
    property int lineWidth: 5
    property real value: 0

    property color primaryColor: "#76fb6a"
    property color secondaryColor: "#327343"

    property int animationDuration: 1000

    width: size
    height: size
    //最大的进度条范围
    onValueChanged: {
        canvas.degree = value * 270;
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

//加渐变
        }

        Behavior on degree {
            NumberAnimation {
                duration: root.animationDuration
            }
        }
    }

    Text {
        id: speedNumber
        text: qsTr("36")
        color: "white"
        anchors{
            centerIn:parent
        }
        font.pixelSize: 24
        font.bold: true
    }

    Text{
        id: symbol
        text: qsTr("knot")
        color: "white"
        anchors{
            horizontalCenter: speedNumber.horizontalCenter
            top:speedNumber.bottom
        }
        font.pixelSize: 15
        font.bold: false
    }

    Text{
        id: kmSymbol
        text: qsTr("54 km/h")
        color: "#76fb6a"
        anchors{
            horizontalCenter: speedNumber.horizontalCenter
            top:symbol.bottom
            topMargin: 10
        }
        font.pixelSize: 9
        font.bold: false
    }

}
