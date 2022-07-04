import QtQuick
import QtQuick.Controls

Rectangle{
        id:root
        width: 96
        height: 48
        color: "#DDDDDD"
        border.width: 0
        border.color: "#DDDDDD"
        radius: 0
        property alias text:buttontext.text //文本
        property alias fontsize: buttontext.font.pixelSize //文本字号
        property alias fontcolor: buttontext.color//文本颜色
        signal clicked
        Text{
            id:buttontext
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                root.clicked()
            }
        }
}
