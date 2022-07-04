import QtQuick
import QtQuick.Controls
import QtCharts
import Qt.labs.settings

Item {
    id:root
    width: 320
    height: 280
    property int currentIndex: -1
    property string thisname : "ChatView"
    Component.onCompleted:{
        console.log("=====[NEW]MicroChartView=====")
    }
    Connections {
        target: eitlinkcore
        function onCubeDataSink (ObjName,JSONData){
            if(ObjName===thisname){
                console.log(JSONData)
                var JS_Data = JSON.parse(JSONData)
                if(JS_Data.TITLE&&JS_Data.DATA){
                    currentIndex++
                    listmodel.append({
                            INDEX:currentIndex,
                            TITLE :JS_Data.TITLE,
                            DATA: Number(JS_Data.DATA).toFixed(3)
                    })
                    var chartCell=chartview.series(listmodel.get(currentIndex).TITLE)
                    if(!chartCell){
                        chartCell = chartview.createSeries(ChartView.SeriesTypeSpline,listmodel.get(currentIndex).TITLE)
                        initchart()
                    }
                    chartCell.append(listmodel.get(currentIndex).INDEX , listmodel.get(currentIndex).DATA);
                    if (listmodel.get(currentIndex).INDEX > 4) {
                        chartview.axisX().max = Number(listmodel.get(currentIndex).INDEX) + 0;
                        chartview.axisX().min = chartview.axisX().max - 5;
                        /*if(listmodel.get(currentIndex).INDEX%7===0){
                            chartview.removeSeries(chartCell)
                        }*/
                    }else {
                        chartview.axisX().max = 5;
                        chartview.axisX().min = 0;
                    }
                    chartview.axisX().tickCount = chartview.axisX().max - chartview.axisX().min + 1;
                }
            }
        }
    }

    ListModel{
        id:listmodel
    }

    ChartView {
        id: chartview
        theme:ChartView.ChartThemeBlueCerulean

        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            bottomMargin: 40
        }
        margins{
            top: 0
            bottom: 0
            left: 0
            right: 4
        }
        legend.alignment: Qt.AlignTop
        animationOptions: ChartView.SeriesAnimations
        antialiasing: true
        /*MouseArea{
            id:mouseArea
            anchors.fill: parent
            property int currentX: 0
            property int currentY: 0
            //获取点击时位置
            onPressed: function(mouse){
                mouseArea.cursorShape = Qt.ClosedHandCursor
                currentX = mouse.x
                currentY = mouse.y
            }
             onReleased: {
                mouseArea.cursorShape = Qt.ArrowCursor
             }
             //拖拽功能实现
            onPositionChanged: function(mouse){
                var moveX = mouse.x-currentX
                //var moveY = mouse.y-currentY
                currentX = mouse.x
                //currentY = mouse.y
                chartview.scrollLeft(moveX)
            }
        }*/
    }
    Component.onDestruction: {
        console.log("=====[Delete]MicroChartView=====")
    }

    function initchart(){
        chartview.axisY().min = -1.5
        chartview.axisY().max = 1.5
        chartview.axisY().tickCount = 7
        chartview.axisY().titleText = "Y轴字段值"
        chartview.axisX().titleText = "X轴字段值"
        chartview.axisX().labelFormat = "%.0f"
        chartview.title="MicroChartView"
    }
}
