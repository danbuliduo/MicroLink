import QtQuick
import QtQuick.Controls
import QtQuick .Dialogs
import Qt5Compat.GraphicalEffects
import VQuickControls
import "qrc:/QmlFile/QuickControl/"
import "qrc:/QmlFile/AppSettings/"
import "qrc:/QmlFile/CoreControl/PageUser/"
Item {
    id:root
    Item{
        id:coretitleItem
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height : 128
        Canvas{
                id:canvas_titlebackground
                anchors.fill: parent
                antialiasing: true
                onPaint:{
                    var ctx  = getContext("2d")
                    ctx.clearRect(0,0,width,height)
                    var gradient = ctx.createLinearGradient(0,0,0,128)
                    gradient.addColorStop(0,"#202020")
                    gradient.addColorStop(1,"#484848")
                    ctx.beginPath()
                    ctx.moveTo(0,0)
                    ctx.lineTo(0,128)
                    ctx.lineTo(width,72)
                    ctx.lineTo(width,0)
                    ctx.closePath()
                    ctx.fillStyle = gradient
                    ctx.fill()
                }
        }
        QcGlowCircularImage{
            id:userimage
            width: 100
            height: 100
            radius:width/2
            anchors.top: parent.top
            anchors.topMargin: 28
            anchors.right: parent.right
            anchors.rightMargin: 28
            antialiasing: true
            source: "qrc:/Resources/Images/debug/user.png"
            glowColor:"#606060"
            spread: 0.8
            glowRadius: 4
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    filedialog.open()
                }
            }
        }
        Text {
            id:text_userName
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 32
            anchors.leftMargin: 16
            text: UserSettings.username
            font.bold: true
            font.pixelSize: 32
            color: "#EEEEEE"
        }
        Text{
            id:text_userID
            anchors.top: text_userName.bottom
            anchors.left: parent.left
            anchors.leftMargin: 16
            text: "UID: ["+UserSettings.userid+"]"
            color: "#AAAAAA"
        }
        FileDialog{
            id:filedialog
            nameFilters: ["Image Files(*.jpg *.png)"]
            onAccepted: {
               userimage.source=filedialog.currentFile
               // UserSettings.userimage=filedialog.currentFile
            }
        }
    }
     Item{
         id:corelistitem
         width: parent.width
         anchors.top: coretitleItem.bottom
         anchors.topMargin: 10
         anchors.bottom: parent.bottom
         Flickable{
             anchors.fill: parent
             clip: true
             contentWidth: width
             contentHeight: Math.max(height ,column.height)
             Column{
                 id:column
                 Repeater{
                     model:ListModel{
                         id:listmodel
                         ListElement{
                             imgurl:"qrc:/Resources/Images/icon/icons8_marked_mail_64px_1.png"
                             itemtitle: "邮 箱"
                             itemnum:8
                         }
                         ListElement{
                             imgurl: "qrc:/Resources/Images/icon/icons8_collaboration_64px.png"
                             itemtitle: "好 友"
                             itemnum:102
                         }
                         ListElement{
                             imgurl:"qrc:/Resources/Images/icon/icons8_related_companies_64px_1.png"
                             itemtitle: "组 织"
                             itemnum:12
                         }
                         ListElement{
                             imgurl:"qrc:/Resources/Images/icon/icons8_filled_bookmark_ribbon_64px.png"
                             itemtitle: "项 目"
                             itemnum:27
                         }
                         ListElement{
                             imgurl:"qrc:/Resources/Images/icon/icons8_high_importance_64px.png"
                             itemtitle: "问题集"
                             itemnum:3
                         }
                         ListElement{
                             imgurl:"qrc:/Resources/Images/icon/icons8_workstation_64px.png"
                             itemtitle: "我的电脑"
                             itemnum: 1
                         }
                     }
                     delegate:Column{
                         ItemDelegate{
                             id:delegateitem
                             width: corelistitem.width
                             height: 54
                             onClicked: {
                                 console.log("*")
                             }
                             Image{
                                 anchors.top: parent.top
                                 anchors.left: parent.left
                                 anchors.topMargin: 15
                                 anchors.leftMargin: 15
                                 width: 24
                                 height: 24
                                 source: imgurl
                             }
                             Text{
                                 anchors.verticalCenter: parent.verticalCenter
                                 anchors.left: parent.left
                                 anchors.leftMargin: parent.height
                                 font.pixelSize: 14
                                 color: "#606060"
                                 text:  itemtitle
                             }
                             Text{
                                 anchors.verticalCenter: parent.verticalCenter
                                 anchors.right: parent.right
                                 anchors.rightMargin: 16
                                 font.italic: true
                                 font.family: "Agency FB"
                                 font.pixelSize: 14
                                 color: "#808080"
                                 text:  itemnum
                             }
                         }
                         Rectangle{
                             anchors.right: parent.right
                             width: delegateitem.width-delegateitem.height
                             height: 1
                             color: "#DDDDDD"
                         }
                     }
                 }
                 ItemDelegate{
                     id:logitem
                     width: corelistitem.width
                     height: 54
                     onClicked: {
                         if(UserSettings.isLogIn){
                             logoutMsgDialog.open()
                         }else{
                             popup_UserLogIn.open()
                             UserSettings.isLogIn=true
                         }
                     }
                     Image{
                         anchors.top: parent.top
                         anchors.left: parent.left
                         anchors.topMargin: 15
                         anchors.leftMargin: 15
                         width: 24
                         height: 24
                         source: UserSettings.isLogIn ? "qrc:/Resources/Images/icon/icons8_Logout_64px.png" :
                                                        "qrc:/Resources/Images/icon/icons8_cloud_backup_restore_64px.png"
                     }
                     Text{
                         anchors.verticalCenter: parent.verticalCenter
                         anchors.left: parent.left
                         anchors.leftMargin: parent.height
                         font.pixelSize: 14
                         color: "#606060"
                         text:  UserSettings.isLogIn ? "注 销" : "登 陆  |  注 册"
                     }
                 }
             }
         }
     }
    UserLogInPopup{
        id:popup_UserLogIn
    }
     VTitleMessageDialog{
         id:logoutMsgDialog
         titletext: "退出登陆"
         messagetext: UserSettings.username+"  当前是否确认退出登陆WeLink?"
         acceptedtext: "确 定"
         refusedtext: "取 消"
         onAccepted: {
             UserSettings.isLogIn = false
         }
     }
}
