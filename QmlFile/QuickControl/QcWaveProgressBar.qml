import QtQuick
import QtQuick.Controls

Canvas{
    id: root
    width: 120
    height: width

    property int nowRange: 0
    property int value: 60
    property alias isRunning: timer.running
    property int linewidth: 16
    //圆
    property double r: root.height / 2             //圆心
    property double canvasR: r -  linewidth     //圆半径
    //Sin曲线
    property double wavewidth: 0.02             //波浪宽度,数越小越宽
    property double waveheight: 4                //波浪高度,数越大越高
    property double speed: 0.08                    //波浪速度，数越大速度越快
    property double offsetX: 0                      //波浪x偏移量
     property int axislength: root.width        //轴长
    property int sX: 0
    property int sY: root.height/ 2
    onPaint: {
        var ctx = getContext("2d")

        ctx.clearRect(0, 0, root.width, root.height)

        //显示外圈
        ctx.beginPath()
        ctx.strokeStyle = '#1c86d1'
        ctx.arc(r, r, canvasR+5, 0, 2*Math.PI)
        ctx.stroke()
        ctx.beginPath()
        ctx.arc(r, r, canvasR, 0, 2*Math.PI)
        ctx.clip()

        //显示sin曲线
        ctx.save();
        var points=[];
        ctx.beginPath();
        for(var x = sX; x < sX + axislength; x += 20 / axislength){
            var y = -Math.sin((sX + x) * wavewidth + offsetX)
            var dY = root.height * (1 - nowRange / 100 )
            points.push([x, dY + y * waveheight])
            ctx.lineTo(x, dY + y * waveheight)
        }

        //显示波浪
        ctx.lineTo(axislength, root.height)
        ctx.lineTo(sX, root.height)
        ctx.lineTo(points[0][0],points[0][1])
        ctx.fillStyle = '#0396FF'
        ctx.fill()
        ctx.restore()

        offsetX += speed
    }

    Timer{
        id: timer
        running: false
        repeat: true
        interval: 10
        onTriggered:{
            parent.requestPaint()
            if(nowRange < value){
                nowRange += 1
            }
        }
    }
    Text{
        id:txt
        text: root.nowRange.toString()+"%"
        anchors.centerIn: parent
        color: "#BBBBBB"
        font.pixelSize: 14
    }
    function start(){
        timer.start()
    }
    function stop(){
        timer.stop()
    }
}
