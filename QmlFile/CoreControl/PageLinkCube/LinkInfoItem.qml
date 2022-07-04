import QtQuick
import QtQuick.Controls
import "qrc:/QmlFile/OpenLib/QMLChartJS/"

Rectangle{
    id:root
    radius: 2
    anchors.fill: parent
    color: "#EEEEEE"
    Item{
        width: parent.width/2
        height: parent.height*0.9
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 2
        QChartJs {
            id: chart_radar
            anchors.fill: parent
            property var data :
            [
                {
                    labels: ["TCPSocket","UDPSocket","MQTT","HTTP","Modbus"],
                    datasets: [{
                          fillColor: "rgba(200,200,200,0.5)",
                          strokeColor: "rgba(200,200,200,1)",
                          pointColor: "rgba(200,200,200,1)",
                          pointStrokeColor: "#fff",
                          data: [65,59,90,81,56]
                      },{
                          fillColor: "rgba(151,187,205,0.5)",
                          strokeColor: "rgba(151,187,205,1)",
                          pointColor: "rgba(151,187,205,1)",
                          pointStrokeColor: "#fff",
                          data: [28,48,40,19,96]
                      }]
                }
            ]
            chartType: "Radar"
            chartData: data[0]
            animation: true
            chartAnimationEasing: Easing.InOutElastic
            chartAnimationDuration: 1000
        }
    }
    Image{
        id:image
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 0
        width: parent.width/2
        height: width*0.75
        source: "qrc:/Resources/Images/base/frontpage-placeholder-columns3.webp"
    }
}
