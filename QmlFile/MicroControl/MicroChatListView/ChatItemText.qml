import QtQuick
import "qrc:/vlian.js" as VLJS
ChatItemBase {
    id: root
  Component.onCompleted: {

      var sertype =  model.isURL ? "URL" : "Text"
      debugsql.sql_INSERT_Data("[Debug]",
                               model.dateTime,
                               model.userName,
                               "Text",
                               sertype,
                               model.textdata)
      console.log(model.textdata,model.dateTime,model.userName,sertype)
  }
    Row{
        width: root.contentWidth
        x:root.isUser ? root.width -timelable.width-root.usernameWidth-root.rightWidth -8
                            : root.sendernameWidth-root.leftWidth+8
        ChatLabel{
            id:timelable
            text:VLJS.time2str(model.dateTime)
            padding: 0
            font.pixelSize: 12
        }
    }
    Row{
        width: root.contentWidth
        layoutDirection: root.isUser ? Qt.RightToLeft : Qt.LeftToRight
        Rectangle{
            id: wrap_item
            radius: 4
            width: text_item.width
            height: text_item.height
            color: root.messageBgColor
            Rectangle{
                width: 8
                height: 8
                y: root.messageHeight/2-8
                anchors.horizontalCenter: root.isUser?parent.right:parent.left
                rotation: 45
                color:root.messageBgColor
            }
            ChatLabel{
                id: text_item
                text: model.textdata
                color: model.isURL? "#336699" : "#606060"
                font.italic: model.isURL
                font.underline: model.isURL
                width: Math.min(root.contentWidth,textWidth)
                MouseArea{
                    anchors.fill: parent
                    visible: model.isURL
                    onClicked: {
                         Qt.openUrlExternally(model.textdata)
                    }
                }
            }
        }
    }
}

