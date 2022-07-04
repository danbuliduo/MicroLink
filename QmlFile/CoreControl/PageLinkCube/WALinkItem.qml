import QtQuick
import QtQuick.Controls
import "qrc:/QmlFile/QuickControl/"

QcPathView{
    id:root
    anchors.fill: parent
    clip: true
    radius:2
    model: ListModel{
        id:basedatamodel
            ListElement{
                titlestr:"TCP"
                thiscolor:"#00a6ac"
                isindex:0
                isOpen: 0
            }
            ListElement{
                titlestr:"UDP"
                thiscolor:"#fcaf17"
                 isindex:1
                isOpen: 0
            }
            ListElement{
                 titlestr:"MQTT"
                 thiscolor:"#2585a6"
                 isindex:2
                 isOpen: 0
            }
            ListElement{
                 titlestr:"HTTP"
                 thiscolor:"#f05b72"
                  isindex:3
                 isOpen: 0
            }
            ListElement{
                 titlestr:"FTP"
                 thiscolor:"#494e8f"
                 isindex:4
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

