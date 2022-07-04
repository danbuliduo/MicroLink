import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import "qrc:/QmlFile/QuickControl/"
import "qrc:/QmlFile/AppSettings/"

import sys.android.system 1.0
import sys.filestream 1.0

ApplicationWindow{
    id:root
    visible: true
    width: BaseSettings.screenwidth
    height: BaseSettings.screenheight
    //!必需加这个,否则窗口会丢失
    flags: Qt.WindowStaysOnTopHint

    property string jsonpath
    property var objectinfo
    property bool opentoolbox:item_menubar.visible
    property int toolboxindex: -1
    Component.onCompleted:{
          jsonpath=BaseSettings.currentPath+item_EILink.objectpath
          console.log( jsonpath)
          objectinfo=JSON.parse(FileStream.readFile(jsonpath,0))
          eitlinkcore.eitCoreModel.clear()
          for(var i=1;i<objectinfo.length;i++){
                eitlinkcore.eitCoreModel.append(objectinfo[i])
          }
    }
    header: ToolBar{
        contentHeight: toolbutton.implicitHeight
        background: Rectangle{
            color: BaseSettings.accentcolor
        }
        ToolButton{
            id:toolbutton
            Image{
                width: height*1.2
                height: toolbutton.height/2
                anchors.centerIn: parent
                source: "qrc:/Resources/Images/icon/icons8_back_64px.png"
            }
            onClicked: {
                item_EILink.closeEILinkTerminal()
            }
        }
        Label{
            text: "OBJECT: "+objectinfo[0].ObjectName
            width: 120
            color: "white"
            font.pixelSize: 18
            font.bold: true
            anchors.left: toolbutton.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle{
        id:menubar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: isV ? 8 : 4
        anchors.topMargin: 4
        width: isV ? parent.width - anchors.leftMargin*2 : 48
        height: isV ? 48 : parent.height - anchors.topMargin*2
        border.width: 1
        border.color: "grey"
        color: "#EEEEEE"
        radius: 4
        ListView{
            id:listview
            anchors.fill: parent
            spacing: 12
            clip: true
            model: ListModel{
                id:listmodel
                ListElement {
                    imgurl: "qrc:/Resources/Images/special/EILinkTerminal/icons8_administrative_tools_96px.png"
                    titlename:"配 置"
                }
                ListElement {
                     imgurl: "qrc:/Resources/Images/special/EILinkTerminal/icons8_refresh_96px.png"
                     titlename:"同 步"
                }
                ListElement {
                     imgurl: "qrc:/Resources/Images/special/EILinkTerminal/icons8_about_96px.png"
                     titlename:"信 息"
                }
                ListElement {
                     imgurl: "qrc:/Resources/Images/special/EILinkTerminal/icons8_flow_chart_96px.png"
                     titlename:"视 图"
                }
                ListElement {
                     imgurl: "qrc:/Resources/Images/special/EILinkTerminal/icons8_module_96px.png"
                     titlename:"模 型"
                }
            }
            orientation: isV? ListView.Horizontal : ListView.Vertical
            delegate: Item{
                width: isV ? height : menubar.width
                height: isV ? menubar.height : width
                Image{
                   id:image
                    width: parent.width *0.64
                    height: width
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: imgurl
                    PropertyAnimation {
                        id:imageAnimation
                        target: image
                        duration: 500
                        easing.type: Easing.OutBounce
                        property: 'scale'
                        from: 0.6
                        to: 1
                    }
                }
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    font.pixelSize: 12
                    color: "#808080"
                    text: titlename
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        imageAnimation.start()
                        switch (index){
                              case 0: {

                              }
                              break
                             case 1: {
                                 objectinfo.splice(1,objectinfo.length)
                                 for(var i=0;i<eitlinkcore.eitCoreModel.count;i++){
                                     objectinfo.push(eitlinkcore.eitCoreModel.get(i))
                                 }
                                 console.log(JSON.stringify(objectinfo,null,4))
                                 FileStream.writeFile( jsonpath, JSON.stringify(objectinfo,null,4), 0)
                             }
                             break
                             case 2: {

                             }
                             break
                             case 3: {
                                 openBox(treeviewbox, index)
                             }
                             break
                             case 4: {
                                 openBox(addmodelbox, index)
                            }
                             break
                        }
                        toolboxindex=index
                    }
                }
                Rectangle{
                    width:  isV ? 2 : parent.width*0.64
                    height: isV ? parent.height*0.6 : 2
                    color: "grey"
                    radius: 2
                    visible: index!==listmodel.count-1
                    anchors.left: {
                        if(isV){ return parent.right}
                    }
                    anchors.leftMargin: {
                        if(isV){ return listview.spacing/2-1 }
                    }
                    anchors.verticalCenter: {
                        if(isV){return parent.verticalCenter}
                    }
                    anchors.top: {
                        if(!isV){return parent.bottom}
                    }
                    anchors.topMargin: {
                        if(!isV){ return listview.spacing/2-1 }
                    }
                    anchors.horizontalCenter: {
                        if(!isV){ return parent.horizontalCenter }
                    }
                }
            }
        }
    }
    Item{
       id:item_menubar
       visible: (width > 8 && height > 8)
       anchors{
           top:isV ? menubar.bottom : parent.top
           bottom: isV ? eitlinkcore.top : parent.bottom
           left: isV? parent.left : menubar.right
           right: isV ? parent.right : eitlinkcore.left
           topMargin: 4
           bottomMargin: 4
           leftMargin: isV ? 8 :4
           rightMargin: isV ? 8 :4
       }
       Loader{
           id:loader_Box
           anchors.fill: parent
           asynchronous: true
           visible: status == Loader.Ready
       }
       Component{
           id:addmodelbox
           EITADDModelBox{ }
       }
       Component{
           id:treeviewbox
           EITTreeViewBox{}
       }
    }
    EITLinkCore{
       id:eitlinkcore
       anchors.bottom: parent.bottom
       anchors.top: isV ? menubar.bottom : parent.top
       anchors.left: isV ? parent.left :menubar.right
       anchors.right: parent.right
       anchors.topMargin: isV ? 4 : 4
       anchors.bottomMargin: isV ? 4 : 4
       anchors.leftMargin: isV ? 8 : 4
       anchors.rightMargin: isV ? 8 : 4
       border.color: "grey"
       color: "#EFEFEF"
       antialiasing: true
    }

    footer: Rectangle{
        height: 24
        color: BaseSettings.colorScheme_VI
        Text{
            anchors.centerIn: parent
            color: "#DDDDDD"
            text: "[Micro Link EI-Terminal] ---- 版本:"+BaseSettings.version +" | © D.Ming 保留所有权"
        }
    }

    ParallelAnimation{
        id:animation_openBox
        NumberAnimation {
            target: eitlinkcore
            property: isV ? "anchors.topMargin" : "anchors.leftMargin"
            duration: 250
            from: 4
            to: 180
        }
    }

    ParallelAnimation{
        id:animation_closeBox
        NumberAnimation {
            target: eitlinkcore
            property: isV ? "anchors.topMargin" : "anchors.leftMargin"
            duration: 250
            from: 180
            to: 4
        }
    }
    Component.onDestruction: {
        console.log("=====[Close]EITermina=====")
    }

    function openBox(object,index){
        if(!opentoolbox){
            loader_Box.sourceComponent=object
            animation_openBox.start()
        }else{
                if(toolboxindex===index){
                      animation_closeBox.start()
                     loader_Box.sourceComponent=undefined
                }else{
                    loader_Box.sourceComponent=object
                }
        }
    }
}
