import QtQuick
import QtQuick.Controls
import QtMultimedia
ChatItemBase{
    id:root
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

            MediaPlayer{
                id: mediaplayer
                source:model.videourl
                audioOutput: AudioOutput {}
                videoOutput: videoOutput
            }
            VideoOutput {
                id: videoOutput
                width: 200
                height: 200
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mediaplayer.play()
                    }
                }
            }
    }
}
