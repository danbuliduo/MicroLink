import QtQuick
import QtQuick.Controls
import "qrc:/QmlFile/QuickControl/"
import "qrc:/QmlFile/CoreControl/PageLinkCube/LALinkTerminal/"
QcPathView{
    id:root
    anchors.fill: parent
    clip: true
    radius:2
    model: ListModel{
        id:basedatamodel
            ListElement{
                 type:"BlueTooth"
                 titlestr:"BlueTooth"
                 thiscolor:"#f05b72"
                 isindex:3
                 isOpen: 0
            }
            ListElement{
                type:"UWB"
                titlestr:"U W B"
                thiscolor:"#20B2AA"
                isindex:0
                isOpen: 0
            }
            ListElement{
                type:"ZigBee"
                titlestr:"ZigBee"
                thiscolor:"#fcaf17"
                 isindex:1
                isOpen: 0
            }
            ListElement{
                 type:"UART"
                 titlestr:"U A R T"
                 thiscolor:"#494e8f"
                 isindex:4
                 isOpen: 0
            }
            ListElement{
                 type:"NFC"
                 titlestr:"N F C"
                 thiscolor:"#2585a6"
                 isindex:2
                 isOpen: 0
            }
    }
    color:"#EEEEEE"
    viewItem: Item{
        id:delegateItem
        width: parent.width*0.3
        height: parent.height*0.8
        z:PathView.iconZ
        scale:PathView.iconScale
        QcGlowRectangle{
            id:itemRect
            width: parent.width
            height: parent.height
            color: "#FFFFFF"
            radius: 8
            glowRadius: 8
            glowColor: thiscolor
            Text{
                text:titlestr
                anchors.top: parent.top
                anchors.topMargin: 16
                anchors.horizontalCenter: parent.horizontalCenter
                color: "grey"
                font.bold:true
                font.pixelSize: 16
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(root.viewindex===index){
                        linkcubecore.typeTitleForTerminal=type
                        linkcubecore.openLALinkTerminal()
                    }
                    root.viewindex=index
                }
            }
        }
        transform: Rotation{
            origin.x:itemRect.width/2.0
            origin.y:itemRect.height/4.0
            axis{x:0;y:1;z:0}
            angle: delegateItem.PathView.iconAngle
        }
    }
}
