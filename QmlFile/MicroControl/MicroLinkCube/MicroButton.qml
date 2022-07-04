import QtQuick
import QtQuick.Controls
import "qrc:/QmlFile/QuickControl/"
Rectangle {
    border.color: "grey"
    antialiasing: true
    radius: 0
    width: 64
    height: 36
    Connections {
        target: eitlinkcore
    }
    Text{
        text: "STOP"
        anchors.centerIn: parent
    }
    Loader{
        anchors.fill: parent
        asynchronous: true
        visible: status === Loader.Ready
        sourceComponent: loader_Box.sourceComponent != undefined ?
                                      undefined : com_MouseArea
    }
    Component{
        id:com_MouseArea
        MouseArea{
            anchors.fill: parent
            onClicked: {
                eitlinkcore.cubeDataSend("STOP")
            }
        }
    }
}
