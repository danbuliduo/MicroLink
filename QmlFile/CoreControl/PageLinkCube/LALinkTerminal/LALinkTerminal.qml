import QtQuick
import QtQuick.Controls
import "qrc:/QmlFile/QuickControl/"
import "qrc:/QmlFile/AppSettings/"
import "qrc:/QmlFile/MicroControl/MicroChatListView/"
QcGlowRectangle{
    id:root
    color: "#FFFFFF"
    radius: 12
    glowRadius: 8
    glowColor:  "#AAAAAA"
    Item{
        id:titleItem
        width: parent.width
        height: 40
        Text{
            anchors.top: parent.top
            anchors.topMargin: 12
            anchors.centerIn: parent
            text:"["+linkcubecore.typeTitleForTerminal+"]-调试终端"
            font.bold: true
            font.pixelSize: 18
            color: "#606060"
        }
        Image{
            id:closeimg
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 4
            width: 40
            height: 40
            source: "qrc:/Resources/Images/icon/color_close_96px .png"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    linkcubecore.closeWLALinkTerminal()
                }
            }
        }
    }
    Item{
        anchors.top: titleItem.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        Loader{
            anchors.fill: parent
            asynchronous: true
            visible: status == Loader.Ready
            sourceComponent: {
                switch(typeTitleForTerminal){
                case "BlueTooth": return item_BlueTooth
                default: return undefined
                }
            }
        }
    }
    Component{
        id:item_BlueTooth
        BlueToothItem{}
    }
}
