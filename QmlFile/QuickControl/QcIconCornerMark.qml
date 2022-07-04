import QtQuick
import QtQuick.Controls
Rectangle{
    id:root
    width: 12
    height: 12
    color: "#606060"
    radius: width/2
    property int icoNumber : 1
    Text {
        id: number
        text: root.icoNumber.toString()
        anchors.centerIn: parent
        color: "white"
    }
}
