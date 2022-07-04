import QtQuick
import sys.filestream
ChatItemBase{
    id:root
    Component.onCompleted:  {
        FileStream.getFileName(model.imgurl)
    }

    Row{
        width: root.contentWidth
        x:root.isUser ? root.width -timelable.width-root.usernameWidth-root.rightWidth -8
                            : root.sendernameWidth-root.leftWidth+8
        ChatLabel{
            id:timelable
            text:model.dateTime
            padding: 0
            font.pixelSize: 12
        }
    }
    Row{
        width: root.contentWidth
        layoutDirection: root.isUser ? Qt.RightToLeft : Qt.LeftToRightt
        Image {
            id:img
            source: model.imgurl
            cache: false
            asynchronous: true
            sourceSize: Qt.size(100, 100)
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onClicked: {
                   console.log(1)
                }
            }
        }
    }
}
