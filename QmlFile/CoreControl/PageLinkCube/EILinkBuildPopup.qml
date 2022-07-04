import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "qrc:/QmlFile/AppSettings/"
import "qrc:/QmlFile/QuickControl/"
import "qrc:/vlian.js" as VLJS
import sys.filestream 1.0
Dialog{
    id:root
    width: isV?  rootAPP.width : rootAPP.width/2
    height: isV? rootAPP.height/2 : rootAPP.height
    x: isV ? 0 : parent.width/2+backrec.radius
    y: isV ? parent.height/2+backrec.radius :-toolbutton.height
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose
    property string jsonpath
    property var objectINI : [{}]
    enter: Transition {
            NumberAnimation {
                property: isV? "y" : "x"
                from:  isV? rootAPP.height : rootAPP.width
                to:  isV? parent.height/2+backrec.radius : parent.width/2+backrec.radius
                duration: 360
            }
    }
    exit: Transition {
            NumberAnimation {
                property: isV? "y" : "x"
                from:  isV? parent.height/2+backrec.radius : parent.width/2+backrec.radius
                to: isV? rootAPP.height : rootAPP.width
                duration: 360
            }
    }
    background: Rectangle{
        id:backrec
        radius: 16
    }
    Loader{
        anchors.fill: parent
        asynchronous: true
        visible: status == Loader.Ready
        sourceComponent: root.visible ? component_EILinkBuildPopop : undefined
    }
    Component{
        id:component_EILinkBuildPopop
        Item{
            anchors.fill: parent
            Item{
                id:titleitem
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: -4
                anchors.leftMargin: isV ? 0 : -16
                height: 48
                Text{
                    text: "[EIT.Link]-构建卡"
                    font.pixelSize: 18
                    font.bold: true
                    color: BaseSettings.accentcolor
                    anchors.centerIn: parent
                }
                Image{
                    width: height
                    height: parent.height
                    anchors.right: parent.right
                    anchors.rightMargin: isV ? -4 : 8
                    source: "qrc:/Resources/Images/icon/color_close_96px .png"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                             root.close()
                        }
                    }
                }
            }
            Item{
                id:coreitem
                anchors.top: titleitem.bottom
                anchors.bottom: bottomitem.top
                anchors.bottomMargin: 16
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: isV ? 0 : 16
                Column{
                    anchors.centerIn: parent
                    spacing: 18
                    QcTextField{
                        id:textfiled_ObjName
                        width: coreitem.width*0.9
                        height: 36
                        leftPadding: 60
                        placeholderText: "New 项目名称"
                        font.pixelSize: 14
                        background: Rectangle{
                            border.color: textfiled_ObjName.focus ? BaseSettings.accentcolor : "grey"
                            radius: 4
                            Image{
                                height: parent.height*0.72
                                width: height
                                source: "qrc:/Resources/Images/icon/icons8_module_64px_1.png"
                                anchors.left: parent.left
                                anchors.leftMargin: 8
                                anchors.verticalCenter: parent.verticalCenter
                                ColorOverlay{
                                    anchors.fill: parent
                                    source: parent
                                    color:textfiled_ObjName.focus ? BaseSettings.accentcolor : "grey"
                                }
                            }
                            Rectangle{
                                height: parent.height*0.64
                                width: 2
                                radius: 1
                                color: textfiled_ObjName.focus ? BaseSettings.accentcolor : "grey"
                                anchors.left: parent.left
                                anchors.leftMargin: 16+parent.height*0.72
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                    QcTextField{
                        id:textfiled_ObjKey
                        width: coreitem.width*0.9
                        height: 36
                        leftPadding: 60
                        placeholderText: "New 访问密钥"
                        font.pixelSize: 14
                        background: Rectangle{
                            border.color: textfiled_ObjKey.focus ? BaseSettings.accentcolor : "grey"
                            radius: 4
                            Image{
                                height: parent.height*0.72
                                width: height
                                source: "qrc:/Resources/Images/icon/icons8_data_encryption_64px.png"
                                anchors.left: parent.left
                                anchors.leftMargin: 8
                                anchors.verticalCenter: parent.verticalCenter
                                ColorOverlay{
                                    anchors.fill: parent
                                    source: parent
                                    color:textfiled_ObjKey.focus ? BaseSettings.accentcolor : "grey"
                                }
                            }
                            Rectangle{
                                height: parent.height*0.64
                                width: 2
                                radius: 1
                                color: textfiled_ObjKey.focus ? BaseSettings.accentcolor : "grey"
                                anchors.left: parent.left
                                anchors.leftMargin: 16+parent.height*0.72
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                    Row{
                        spacing: 8
                        Image{
                            width: height
                            height: radiobutton_Private.height*0.8
                            source: "qrc:/Resources/Images/icon/icons8_lock_64px.png"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        RadioButton{
                             id: radiobutton_Private
                             text: "Private"
                             padding: 0
                             Material.accent: BaseSettings.accentcolor
                             font.pixelSize: 12
                             checked: true
                             onClicked: {
                                 radiobutton_Private.checked=true
                                 radiobutton_Public.checked=false
                             }
                        }
                        Text{
                            text: "设置为私有属性时,访问此项目需要密钥验证权限"
                            font.pixelSize: 10
                            font.italic: true
                            color: "#808080"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Row{
                        spacing: 8
                        Image{
                            width: height
                            height: radiobutton_Private.height*0.8
                            source: "qrc:/Resources/Images/icon/icon8_bookmark_documents_64px.png"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        RadioButton{
                             id: radiobutton_Public
                             text: "Public"
                             padding: 0
                             Material.accent: BaseSettings.accentcolor
                             font.pixelSize: 12
                             checked: false
                             onClicked: {
                                 radiobutton_Private.checked=false
                                 radiobutton_Public.checked=true
                             }
                        }
                        Text{
                            text: "设置为公开属性时,密钥失效,无需验证即可访问"
                            font.pixelSize: 10
                            font.italic: true
                            color: "#808080"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
            Item{
                id:bottomitem
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: isV ? 10 : 0
                anchors.leftMargin: isV ? 0 : -16
                height: 42
                QcButton{
                    anchors.left: parent.left
                    anchors.leftMargin: isV ? 16 :32
                    width: parent.width*0.4
                    height: 36
                    text: "云 端 构 建"
                    color: BaseSettings.accentcolor
                    fontcolor: "#EEEEEE"
                    radius: 4
                    onClicked: {
                        root.close()
                    }
                }
                QcButton{
                    anchors.right: parent.right
                    anchors.rightMargin: isV ? 16 :32
                    width: parent.width*0.4
                    height: 36
                    text: "快 速 构 建"
                    color: "#808080"
                    fontcolor: "#EEEEEE"
                    radius: 4
                    onClicked: {
                        jsonpath= BaseSettings.currentPath+"/USER/root/Item/Local/"+textfiled_ObjName.text+".json"
                        if(FileStream.isExistSpecificFile(jsonpath)){
                            console.log("此文件已存在")
                        }else{
                            objectINI[0]=({
                                               ObjectID : "425D41317CCB",
                                               ObjectKey : textfiled_ObjKey.text,
                                               ObjectName:textfiled_ObjName.text,
                                               ObjectType:"LOCAL",
                                               ObjectPath:"/USER/root/Item/Local/"+textfiled_ObjName.text+".json",
                                               CreatTime: VLJS.dateTime("[yyyy-MM-dd] hh:mm:ss"),
                                               CoreCHIP:"Link-Zero",
                                               Development: radiobutton_Private.checked ? "Private" : "Public"
                                           })
                            FileStream.buildFile(jsonpath)
                            FileStream.writeFile(jsonpath,JSON.stringify(objectINI,null,4),jsonpath)
                            linkcubecore.linkBuildInit(objectINI)
                            root.close()
                        }
                    }
                }
            }
        }
    }
}
