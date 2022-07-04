import QtQuick
import QtQuick.Controls
ProgressBar{
    id:root
    width: 200
    height: 4
    value: 0.0
    property double radius : 0
    property alias backcolor: backRect.color//背景色
    property alias contcolor: contRect.color //填充色
    background:Rectangle{
        id:backRect
        implicitWidth: root.width
        implicitHeight: root.height
        radius: root.radius
        color: "#FEBAC0"
    }
    contentItem: Rectangle{
        id:contRect
        visible: value > 0.0
        width: root.value*root.width
        height: root.height
        radius:root.radius
        color: "#F05B60"
    }
}
