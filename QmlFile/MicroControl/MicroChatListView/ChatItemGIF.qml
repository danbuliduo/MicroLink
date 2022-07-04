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
        layoutDirection: root.isUser ? Qt.RightToLeft : Qt.LeftToRight
        AnimatedImage{
            source: model.imgurl
            cache: true
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }
    }
}

