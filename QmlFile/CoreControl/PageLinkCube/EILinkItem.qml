import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import "qrc:/QmlFile/AppSettings/"
import "qrc:/QmlFile/CoreControl/PageLinkCube/EILinkTerminal/"
import "qrc:/vlian.js" as VLJS
import sys.filestream 1.0
import sys.sql 1.0
Rectangle{
    id:root
    property point clickPos: "0,0"
    property string objectpath
    color:"#FFFFFF"
    anchors.fill: parent
    anchors.margins: isV ? 12 : 8
    radius: 8
    Item{
        id:linkIntegrationItem
        height: 50
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        Text{
            text: "[EI-Link] - 弹性集成终端"
            color: BaseSettings.accentcolor
            anchors.centerIn: parent
            font.pixelSize: 16
        }
    }
    Rectangle{
        anchors{
            top: linkIntegrationItem.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: 10
            rightMargin: 10
            bottomMargin: 20
        }
        radius: 1
        color: "#F0F0F4"
        border.color: BaseSettings.accentcolor
        Image{
            id:image
            anchors.fill: parent
            anchors.margins: isV ? 32 : 8
            smooth: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/Resources/Images/base/frontpage-placeholder-columns2.webp"
        }
        ListView{
            id:listview
            Component.onCompleted: {
                currentIndex=-1
                itemlistsql.updateItem()
            }
            model: ListModel{ id:listmodel }
            clip:true
            visible: count>0
            anchors.fill: parent
            anchors.margins:1
            spacing : 2
            delegate: Rectangle{
                    id:delegateRect
                    width: listview.width
                    height: 48
                    color: listview.currentIndex===index?  "#AADDDDDD" : "#AAFFFFFF"
                    Image{
                        id:itemimg
                        anchors.left: parent.left
                        anchors.leftMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*0.6
                        width: height
                        source: "qrc:/Resources/Images/icon/icons8_electronics_64px_1.png"
                    }
                    Text{
                        id:itemchip
                        text: CoreCHIP
                        color: "#404040"
                        font.italic: true
                        anchors.left: itemimg.right
                        anchors.leftMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text{
                        id:itemtitle
                        anchors.centerIn: parent
                        text: ObjectName
                        color: "#303030"
                        font{
                            pixelSize: 15
                        }
                    }
                    Text{
                        id:statetext
                        anchors.left: itemtime.left
                        anchors.leftMargin: 0
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        text: "状态: "
                        font.pixelSize: 10
                        color: "#606060"
                    }
                    Text {
                        id: itemstate
                        anchors.left:statetext.right
                        anchors.leftMargin: 0
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        text: "NotActive"
                        font.italic: true
                        font.pixelSize: 10
                        color: "#FC354C"
                    }
                    Text{
                        id:itemtime
                        anchors.right: parent.right
                        anchors.rightMargin: 12
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 6
                        text: CreatTime
                        color: "#404040"
                        font.pixelSize: 10
                    }
                    MouseArea{
                        id:mousearea
                        anchors.fill: parent
                        onDoubleClicked: {
                            objectpath=ObjectPath
                            openEILinkTerminal()
                        }
                        onPressAndHold: {
                             objectpath=ObjectPath
                             openEILinkTerminal()
                        }
                        onPressed: function(mouse){
                            clickPos  = Qt.point(mouse.x,mouse.y)
                            listview.currentIndex=index
                        }
                        onReleased: function(mouse){
                            var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                            if ((delta.x < 0) && (animationBtnShow.running === false) && (itemBtn.width === 0)){
                                animationBtnShow.start()
                            }else if (animationBtnHide.running === false && (itemBtn.width > 0)){
                                animationBtnHide.start()
                            }
                        }
                    }
                    Rectangle{
                        id: itemBtn
                        visible: width>0
                        width: 0
                        height: parent.height
                        anchors.left:  parent.right
                        LinearGradient{
                            anchors.fill: parent
                            start: Qt.point(0,0)
                            end: Qt.point(width,0)
                            gradient: Gradient{
                                GradientStop {  position: 0.0;    color: "#FC354C" }
                                GradientStop {  position: 1.0;    color: "#0ABFBC" }
                            }
                        }
                        Item{
                            height: parent.height
                            width: parent.width/2
                            anchors.left: parent.left
                            Text {
                                font.pointSize: 12
                                anchors.centerIn: parent
                                text: "删  除"
                                color: "#EEEEEE"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    console.time("sort")
                                    FileStream.deleteFile(BaseSettings.currentPath+ObjectPath)
                                    itemlistsql.sql_DELETE_Data(itemtitle.text)
                                    listview.model.remove(index)
                                    console.timeEnd("sort")
                                    listview.currentIndex=-1
                                }
                            }
                        }
                        Rectangle{
                            height: parent.height
                            width: 0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "#BBBBBB"
                        }
                        Item{
                            height: parent.height
                            width: parent.width/2
                            anchors.right:parent.right
                            Text {
                                font.pointSize: 12
                                anchors.centerIn: parent
                                text: "置  顶"
                                color: "#EEEEEE"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    animationBtnHide.start()
                                    listmodel.move(index,0,1)
                                    listview.currentIndex=index
                                    listview.positionViewAtBeginning()
                                }
                            }
                        }
                        ParallelAnimation{
                            id: animationBtnShow
                            NumberAnimation {
                                target: itemBtn
                                property: "width"
                                duration: 100
                                from: 0
                                to: 100
                            }
                            NumberAnimation{
                                target: delegateRect
                                property: "x"
                                duration: 100
                                from: 0
                                to: -100
                            }
                        }
                        ParallelAnimation{
                            id: animationBtnHide
                            NumberAnimation {
                                target: itemBtn
                                property: "width"
                                duration: 100
                                from: 100
                                to: 0
                            }
                            NumberAnimation {
                                target: delegateRect
                                property: "x"
                                duration: 100
                                from: -100
                                to: 0
                            }
                        }
                    }
            }
        }
    }

    Rectangle{
        width: 48
        height: width
        radius: width/2
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 36
        anchors.rightMargin: 24
        color: BaseSettings.accentcolor
        Image {
            anchors.fill: parent
            anchors.margins: 12
            source: "qrc:/Resources/Images/icon/icons8_plus_math_48px.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                popup_EILinkBuild.open()
            }
        }
    }
    ItemListSQL{
        id:itemlistsql
         onCallUpDdteItem : function(jsondata){
             updateListModel(jsondata)
         }
    }
    Loader{
        id:loader_EILinkTerminal
        asynchronous: true
        visible: status === Loader.Ready
    }
    Component{
        id:component_EILinkTerminal
        EILinkTerminal{}
    }
    function linkBuildInit(JSData){
             console.time("sort")
            listview.currentIndex=-1
            listmodel.append({
                    ObjectID:JSData[0].ObjectID,
                    ObjectKey:JSData[0].ObjectKey,
                    ObjectName:JSData[0].ObjectName,
                    ObjectType:JSData[0].ObjectType,
                    ObjectPath:JSData[0].ObjectPath,
                    CreatTime:JSData[0].CreatTime,
                    CoreCHIP:JSData[0].CoreCHIP,
                    Development:JSData[0].Development
             })
             itemlistsql.sql_INSERT_Data(
                 JSData[0].ObjectID,
                 JSData[0].ObjectKey,
                 JSData[0].ObjectName,
                 JSData[0].ObjectType,
                 JSData[0].ObjectPath,
                 JSData[0].CreatTime,
                 JSData[0].CoreCHIP,
                 JSData[0].Development
             )
            console.timeEnd("sort")
            listview.positionViewAtEnd()
    }
    function updateListModel(jsondata){
        var JSData=JSON.parse(jsondata)
        listmodel.append({
                ObjectID:JSData.ObjectID,
                ObjectKey:JSData.ObjectKey,
                ObjectName:JSData.ObjectName,
                ObjectType:JSData.ObjectType,
                ObjectPath:JSData.ObjectPath,
                CreatTime:JSData.CreatTime,
                CoreCHIP:JSData.CoreCHIP,
                Development:JSData.Development
         })
    }
    function openEILinkTerminal(){
        linkcubecore.visible=false
        loader_EILinkTerminal.sourceComponent=component_EILinkTerminal
    }
    function closeEILinkTerminal(){
        loader_EILinkTerminal.sourceComponent=undefined
        linkcubecore.visible=true
    }
}
