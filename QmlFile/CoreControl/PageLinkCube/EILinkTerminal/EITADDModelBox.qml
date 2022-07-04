import QtQuick
import QtQuick.Controls
import "qrc:/QmlFile/QuickControl/"
import "qrc:/QmlFile/AppSettings/"
Rectangle{
    anchors.fill: parent
    radius: 2
    border.color: BaseSettings.accentcolor
    ListView{
        id:listview
        anchors.fill: parent
        anchors.margins: 4
        spacing: 6
        clip: true
        orientation: isV ? ListView.Horizontal : ListView.Vertical
        model: ListModel{
            id:listmodel
            ListElement{objname: "ChartView"}
            ListElement{objname: "Button" }
            ListElement{objname: "Lable" }
            ListElement{objname: "ImageFrame" }
        }
        delegate: Rectangle{
            id:delegateRect
            height: isV ? listview.height : 64
            width: isV ? 64 : listview.width
            border.color: "grey"
            radius: 1
            property bool haveshow: false
                ItemDelegate{
                    anchors.top: parent.top
                    anchors.left: parent.left
                    width: isV ? 64 : parent.width
                    height: isV? parent.height : 64
                    Text{
                        text: objname
                        anchors.centerIn: parent
                        font.family: "Agency FB"
                        font.bold: true
                        color: "#404040"
                    }
                    onClicked: {
                        if(!delegate_show_animation.running){
                            delegate_show_animation.start()
                        }
                        //addModel(index)
                    }
                }

            PropertyAnimation{
                id:delegate_show_animation
                target: delegateRect
                property: isV ? "width" : "height"
                from: delegateRect.haveshow ? 256 : 64
                to:delegateRect.haveshow ? 64 : 256
                duration: 200
                onStopped: {
                    delegateRect.haveshow^=1
                }
            }
        }
    }
    function addModel(index){
        switch(index){
            case 0:{
                eitlinkcore.eitCoreModel.append({
                         OBJ_ID: "OFGC-001",
                         OBJ_Name: "ChatView",
                         OBJ_Width: 320,
                         OBJ_Height: 280,
                         OBJ_X:0,
                         OBJ_Y:0,
                })
            }
            break
            case 1:{
                eitlinkcore.eitCoreModel.append({
                        OBJ_ID: "OFGC-002",
                        OBJ_Name: "Button",
                        OBJ_Width: 72,
                        OBJ_Height: 48,
                        OBJ_X:0,
                        OBJ_Y:240,
                })
            }
            break
            case 2:{
                eitlinkcore.eitCoreModel.append({
                        OBJ_ID: "OFGC-003",
                        OBJ_Name: "Lable",
                        OBJ_Width: 60,
                        OBJ_Height: 32,
                        OBJ_X:0,
                        OBJ_Y:240,
                })
            }
            break
            case 3:{
                eitlinkcore.eitCoreModel.append({
                        OBJ_ID: "OFGC-004",
                        OBJ_Name: "ImageFrame",
                        OBJ_Width: 320,
                        OBJ_Height: 240,
                        OBJ_X:0,
                        OBJ_Y:0,
                })
            }
            break
            case 4:{
                eitlinkcore.eitCoreModel.append({
                        OBJ_ID: "OFGC-005",
                        OBJ_Name: "UButton",
                        OBJ_Width: 72,
                        OBJ_Height: 48,
                        OBJ_X:0,
                        OBJ_Y:240,
                })
            }
            break
            case 5:{
                eitlinkcore.eitCoreModel.append({
                        OBJ_ID: "OFGC-006",
                        OBJ_Name: "DButton",
                        OBJ_Width: 72,
                        OBJ_Height: 48,
                        OBJ_X:0,
                        OBJ_Y:240,
                })
            }
            break
            case 6:{
                eitlinkcore.eitCoreModel.append({
                        OBJ_ID: "OFGC-007",
                        OBJ_Name: "RButton",
                        OBJ_Width: 72,
                        OBJ_Height: 48,
                        OBJ_X:0,
                        OBJ_Y:240,
                })
            }
            break
            case 7:{
                eitlinkcore.eitCoreModel.append({
                        OBJ_ID: "OFGC-008",
                        OBJ_Name: "LButton",
                        OBJ_Width: 72,
                        OBJ_Height: 48,
                        OBJ_X:0,
                        OBJ_Y:240,
                })
            }
            break
        }
    }
}
