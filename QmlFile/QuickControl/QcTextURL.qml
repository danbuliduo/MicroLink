import QtQuick
Text {
    id:root
    property string url : "https://www.baidu.com"
    text: url
    font.italic: true
    font.underline: true
    color: "#336699"
    MouseArea {
       anchors.fill: parent
       hoverEnabled: true
       cursorShape: (containsMouse? Qt.PointingHandCursor: Qt.ArrowCursor)
       onClicked: Qt.openUrlExternally(url)
   }
}
