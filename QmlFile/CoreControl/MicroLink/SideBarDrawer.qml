import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import "qrc:/QmlFile/AppSettings/"
import "qrc:/QmlFile/QuickControl/"
Drawer{
    y:rootAPP.header.height
    width: isV ? rootAPP.width/2 : rootAPP.width/4
    height: swipview.height
    edge: Qt.LeftEdge
    modal: true
    closePolicy:  Popup.CloseOnPressOutside
    background:Rectangle {
        color:Qt.rgba(1,1,1,0.6)
    }
    Flickable{
        anchors.fill: parent
        clip: true
        contentWidth: width
        contentHeight: Math.max(height,column.height)
        Row{
             y:parent.width/20
             x:parent.width/20
             width: parent.width*19/20
             spacing: parent.width/20
             Rectangle{
                 width: parent.width/16
                 height: parent.width/16
                 radius: parent.width/16
                 color: "#F05B72"
             }
             Rectangle{
                 width: parent.width/16
                 height: parent.width/16
                 radius: parent.width/16
                 color: "#FFE600"
             }
             Rectangle{
                 width: parent.width/16
                 height: parent.width/16
                 radius: parent.width/16
                 color: "#00AE9D"
             }
        }
        Column{
            id:column
            width: parent.width
            Item{
                id:useritem
                width: parent.width
                height: width
                QcGlowRectangle{
                    id:userglowRec
                    width: parent.width*0.8
                    height: width*0.7
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: userimage.top
                    anchors.topMargin: userimage.height/2
                    color: "#FFFFFF"
                    radius: 4
                    glowRadius: 4
                    glowColor: BaseSettings.colorScheme_VI
                }
                QcGlowCircularImage
                {
                    id:userimage
                    width: parent.width*0.3
                    height: width
                    radius: width/2
                    source: UserSettings.userimage
                    anchors.top: parent.top
                    anchors.topMargin: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    spread: 0.8
                    glowRadius: 4
                    glowColor: BaseSettings.colorScheme_II
                    bordercolor: BaseSettings.accentcolor
                    opacitymaskmargin : 6
                    haveborder: true
                    ColorAnimation
                    {
                        target: userimage
                        property: "glowColor"
                        from: BaseSettings.colorScheme_VI
                        to: BaseSettings.colorScheme_II
                        duration: 1000
                        running: true
                        easing.type: Easing.Linear
                        property bool reverse: false
                        onStopped:
                        {
                            from = reverse ? BaseSettings.colorScheme_VI : BaseSettings.colorScheme_II
                            to = reverse ? BaseSettings.colorScheme_II : BaseSettings.colorScheme_VI
                            reverse = !reverse
                            running = true
                        }
                    }
                }
            }
            Item{
                id:useritem1
                width: parent.width
                height: width
            }
            Item{
                id:useritem2
                width: parent.width
                height: width
            }
        }
    }
}
