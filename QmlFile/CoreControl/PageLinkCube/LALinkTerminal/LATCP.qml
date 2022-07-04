import QtQuick
import VMagicEffect
Item {
    Item{
        width:  isV? parent.width : 200
        height: isV? 200 : parent.height-titleItem.height
        anchors.top: titleItem.bottom
        Item{
            anchors.fill: parent
            anchors.margins: 8
            VFlipHorizontal{
                id:flipable
                anchors.fill: parent
                front: tcpclientRec
                back: tcpserverRec
                MouseArea{
                    anchors.fill: parent
                    onDoubleClicked: {
                        flipable.startOverturn()
                    }
                }
            }
        Rectangle{
            id:tcpclientRec
            width:parent.width
            height: parent.height
            anchors.centerIn: parent
             color: Qt.rgba(0.8,0.8,0.8,0.8)
             radius: 8
             Text{
                 anchors.top: parent.top
                 anchors.topMargin: 4
                 anchors.horizontalCenter: parent.horizontalCenter
                 text: qsTr("TCP   Client")
                 color: "#20B2AA"
                 font {
                     pixelSize: 16
                     bold: true
                     family: "Agency FB"
                 }
             }
        }
        Rectangle{
            id:tcpserverRec
            width:parent.width
            height: parent.height
            anchors.centerIn: parent
             color: Qt.rgba(0.8,0.8,0.8,0.8)
             radius: 8
             Text{
                 anchors.top: parent.top
                 anchors.topMargin: 4
                 anchors.horizontalCenter: parent.horizontalCenter
                 text: qsTr("TCP   Server")
                 color: "#20B2AA"
                 font {
                     pixelSize: 16
                     bold: true
                     family: "Agency FB"
                 }
             }
        }
        }
    }
}
