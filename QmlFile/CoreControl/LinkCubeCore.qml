import QtQuick
import QtQuick.Controls

import "qrc:/QmlFile/AppSettings/"
import "qrc:/QmlFile/CoreControl/PageLinkCube/"
import "qrc:/QmlFile/CoreControl/PageLinkCube/LALinkTerminal/"
import "qrc:/QmlFile/CoreControl/PageLinkCube/EILinkTerminal/"

Item {
    id:root
    property bool isUP : true
    property string typeTitleForTerminal
    Item{
        id:frameitem0
        width: isV ? parent.width : parent.width/2
        height:  isV ? parent.height*0.4 : parent.height
        anchors{
            top: parent.top
            left: parent.left
        }
        Rectangle{
            anchors.fill: parent
            anchors.margins: isV ? 12 : 8
            Item{
                id:tabbarItem
                height: parent.height
                width: 50
                anchors.left: parent.left
                anchors.leftMargin: 2
                Rectangle{
                    anchors.top: parent.top
                    anchors.left: parent.left
                    height: tabbarItem.height/2
                    width: tabbarItem.width-singLine.width
                    Text{
                        text: "WA-Link"
                        rotation: 90
                        anchors.centerIn: parent
                        font.bold: isUP ? true : false
                        color: isUP ? BaseSettings.accentcolor : "#606060"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(!isUP){
                                 animation_singLineup.start()
                            }
                            isUP=true
                        }
                    }
                }
                Rectangle{
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    height:tabbarItem.height/2
                    width: tabbarItem.width-singLine.width
                    Text{
                        text: "LA-Link"
                        rotation: 90
                        anchors.centerIn: parent
                        font.bold: isUP ? false : true
                        color: isUP ? "#606060" : BaseSettings.accentcolor
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(isUP){
                                 animation_singLinedown.start()
                            }
                            isUP=false
                        }
                    }
                }
            }

            Rectangle{
                id:singLine
                height: tabbarItem.height/2
                width: 2
                color:BaseSettings.accentcolor
                anchors.top: isUP ? itemObject1.top : itemObject0.top
                ParallelAnimation{
                    id:animation_singLinedown
                    NumberAnimation{
                       target: itemObject0
                       property: "anchors.bottomMargin"
                       duration: 200
                       from:tabbarItem.height/2
                       to:0
                    }
                    NumberAnimation{
                       target: itemObject1
                       property: "anchors.topMargin"
                       duration: 200
                       from:tabbarItem.height/2
                       to:0
                    }
                }
                ParallelAnimation{
                    id:animation_singLineup
                    NumberAnimation{
                       target: itemObject0
                       property: "anchors.bottomMargin"
                       duration: 200
                       from: tabbarItem.height/2
                       to: 0
                    }
                    NumberAnimation{
                       target: itemObject1
                       property: "anchors.topMargin"
                       duration: 200
                       from: tabbarItem.height/2
                       to: 0
                    }
                }
            }

            Item{
                id:itemObject0
                anchors.right: parent.right
                anchors.left: tabbarItem.right
                anchors.bottom: parent.bottom
                height: tabbarItem.height/2
                Loader{
                    anchors.fill: parent
                    asynchronous: true
                    //visible: status === Loader.Ready
                    sourceComponent: isUP ? component_LinkInfoItem : component_LALinkItem
                }
            }
            Item{
                id:itemObject1
                anchors.right: parent.right
                anchors.left: tabbarItem.right
                anchors.top: parent.top
                height: tabbarItem.height/2
                Loader{
                    anchors.fill: parent
                    asynchronous: true
                    sourceComponent: {
                        return isUP ? component_WALinkItem : component_LinkInfoItem
                    }
                }
            }
            Component{
                id:component_LinkInfoItem
                LinkInfoItem{}
            }
            Component{
                id:component_WALinkItem
                WALinkItem{}
            }
            Component{
                id:component_LALinkItem
                LALinkItem{}
            }
        }
    }

    Item{
        id:frameitem1
        width: isV ? parent.width : parent.width/2
        height:  isV ? parent.height*0.6 : parent.height
        anchors{
            bottom: parent.bottom
            right: parent.right
        }
        EILinkItem{
            id: item_EILink
        }
    }

    EILinkBuildPopup{
        id:popup_EILinkBuild
    }
    Loader{
        id:loader_WLALinkTerminal
        asynchronous: true
        visible: status === Loader.Ready
        anchors.fill: parent
        anchors.margins: 8
    }
    Component{
        id:component_LALinkTerminal
        LALinkTerminal{}
    }
    function openLALinkTerminal(){
        frameitem0.visible=false
        frameitem1.visible=false
        loader_WLALinkTerminal.sourceComponent=component_LALinkTerminal
    }
    function closeWLALinkTerminal(){
        frameitem0.visible=true
        frameitem1.visible=true
        loader_WLALinkTerminal.sourceComponent= undefined
    }
    function linkBuildInit(JSData){
        console.log(JSON.stringify(JSData,null,4))
        item_EILink.linkBuildInit(JSData)
    }
}
