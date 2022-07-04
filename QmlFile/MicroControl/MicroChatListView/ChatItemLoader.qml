import QtQuick

Rectangle{
    id:root
    anchors.fill: parent
    color: "#000000"
    MouseArea{
        anchors.fill: parent
        onClicked: {
            root.visible=false
        }
    }
}
