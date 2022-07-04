import QtQuick
import QtQuick.Layouts
import "qrc:/QmlFile/AppSettings/"
import "qrc:/QmlFile/QuickControl/"
import QtQuick.Dialogs
Item {
    id: root

    width: parent.ListView.view.width
    height: Math.max(profileHeight,  content_item.height)

    property int profileHeight: 60
    property int messageHeight: 36

    property int leftWidth: 60
    property int rightWidth: 60
    property int contentWidth: Math.max(10,root.width-root.leftWidth-root.rightWidth)
    property bool isUser: model.isUser
    property color messageBgColor: root.isUser?"#98E892":"#FFFFFF"
    property alias sendernameWidth:sendername.width
    property alias usernameWidth: username.width
    default property alias contentItems: content_item.children

    Item{
        id: left_item
        visible: !root.isUser
        height: root.height
        width: root.leftWidth
        anchors.left: parent.left
        Column{
            spacing: 6
            Text{
                id:sendername
                text: model.senderName
            }
            Rectangle{
                width: height
                height: root.profileHeight-sendername.height
                border.color: "grey"
                antialiasing : true
                Image {
                    anchors.fill: parent
                    anchors.margins: 1
                    source: UserSettings.userimage
                }
            }
        }
    }
    Column{
        id: content_item
        x: root.isUser ? root.rightWidth-spacing : root.leftWidth-spacing+8
        width: root.contentWidth
        spacing: 12
    }
    Item{
        id: right_item
        height: root.height
        width: root.rightWidth
        visible: root.isUser
        anchors.right: parent.right
        Column{
           spacing: 6
           Text{
               id:username
               text: model.userName
           }
           Rectangle{
               width: height
               height:root.profileHeight-username.height
               border.color: BaseSettings.accentcolor
               antialiasing : true
               Image{
                   id:userimage
                   anchors.fill: parent
                   anchors.margins: 1
                   source: UserSettings.userimage
               }
           }
        }
    }
}
