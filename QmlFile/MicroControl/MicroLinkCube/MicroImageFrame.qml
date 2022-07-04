import QtQuick
import QtQuick.Controls
Rectangle {
    id:root
    color: "black"
    width: 320
    height: 240
    Connections {
        target: eitlinkcore
        function onCubeImageSink(){
            image.source="image://microImageProvider/0"
            image.source="image://microImageProvider/1"
        }
    }
    Image{
        id:image
        anchors.fill: parent
         //sourceSize: Qt.size(root.width,root.height)
        cache: false
        asynchronous: true
        fillMode: Image.PreserveAspectFit
    }
}

