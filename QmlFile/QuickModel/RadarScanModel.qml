import QtQuick
import QtQuick.Controls
Rectangle
{
    id:root
    width:200
    height:200
    radius: width/2
    color:"#000000"
    property int angle : 0
    Timer
    {
        interval:25
        running:true
        repeat:true
        onTriggered:
        {
            root.angle+=1
            if(root.angle===360)
            {
                  root.angle=0
            }
        }
    }
    Item
    {
        anchors.fill:parent
        Canvas
        {
            anchors.fill:parent
            onPaint:
            {
                var ctx=getContext("2d");
                ctx.lineWidth=2;
                ctx.strokeStyle="#32DD32";
                ctx.fillStyle="#32DD32";
                ctx.globalAlpha=1.0;
                ctx.beginPath();
                ctx.arc(width/2,width/2,2,0,2*Math.PI);
                ctx.stroke();
                ctx.fill()
                ctx.restore();
                ctx.beginPath();
                ctx.arc(width/2,width/2,width/10,0,2*Math.PI);
                ctx.stroke();
                ctx.restore();
                ctx.beginPath();
                ctx.arc(width/2,width/2,width*2/10,0,2*Math.PI);
                ctx.stroke();
                ctx.restore();
                ctx.beginPath();
                ctx.arc(width/2,width/2,width*3/10,0,2*Math.PI);
                ctx.stroke();
                ctx.restore();
                ctx.beginPath();
                ctx.arc(width/2,width/2,width*4/10,0,2*Math.PI);
                ctx.stroke();
                ctx.restore();
                ctx.beginPath();
                ctx.arc(width/2,width/2,width*5/10-1,0,2*Math.PI);
                ctx.stroke();
                ctx.restore();
                ctx.beginPath();
                ctx.lineTo(0,width/2)
                ctx.lineTo(width,width/2)
                ctx.stroke();
                ctx.restore();
                ctx.beginPath();
                ctx.lineTo(width/2,0)
                ctx.lineTo(width/2,width)
                ctx.stroke();
                ctx.restore();
            }
        }
        Canvas{
            anchors.fill:parent
            rotation:-root.angle
            onPaint:
            {
                var ctx=getContext("2d");
                ctx.lineWidth=2;
                var sectorCnt=30;
                var startDeg=90,endDeg;
                var sectorRadius=width/2
                ctx.translate(sectorRadius,sectorRadius);
                ctx.fillStyle='rgba(0,255,0,0.04)';
                for(var i=0;i<sectorCnt;i++)
                {
                    endDeg=startDeg+60-60/sectorCnt*i;
                    ctx.beginPath();
                    ctx.moveTo(0,0);
                    ctx.lineTo(0,-sectorRadius);
                    ctx.arc(0,0,sectorRadius,Math.PI/180*(startDeg),Math.PI/180*endDeg);
                    ctx.closePath();
                    ctx.fill();
                }
            }
        }
    }
}
