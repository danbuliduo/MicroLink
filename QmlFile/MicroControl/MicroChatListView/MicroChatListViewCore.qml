import QtQuick
import QtQuick.Controls
import QtQuick .Dialogs
import "qrc:/QmlFile/QuickControl/"
import "qrc:/QmlFile/AppSettings/"
import sys.android.notification 1.0
import model.chatmodel 1.0
import lps.tcp 1.0
import sys.sql
Rectangle{
    id:root
    anchors.fill: parent
    anchors.margins: 4
    radius: 4
    border.color: "grey"
    color: "#EEEEEE"
    property bool isH: rootAPP.height>rootAPP.width
    Component.onCompleted: {
         debugsql.sql_Loader_Data("[DeBug]")
    }
    TcpServer{
        id:tcpserver
        onCallMessageSink: function(message){
             talk_model.appendText(false,0,1,message,false)
        }
        onCallNewConnect: function(ip,port){
            AndroidNotifiCation.setNotification("一个新的连接成功建立")
        }
        onCallDisConnect: function(ip,port){
            AndroidNotifiCation.setNotification("一个连接同步已断开")
        }
    }
    FriendListSQL{
        id:debugsql
        onCallLoaderData: function(dataMap){
            console.log(dataMap.TimeStamp,dataMap.DataOwner,
                        dataMap.DataType,dataMap.SecType,dataMap.URL)

        }
    }
    Timer{
        id: update_timer
        interval: 100
        repeat: false
        onTriggered: {
            microChatView.positionViewAtEnd();
            microChatView.currentIndex=microChatView.count-1;
        }
    }
    ChatListModel{
        id:talk_model
        onModelReset: {
            update_timer.start()
        }
        onRowsInserted: {
            update_timer.start()
        }
    }
    MicroChatListView{
        id: microChatView
        anchors{
            top: parent.top
            right: isH ? parent.right : toolBox.left
            left: parent.left
            bottom: inputMenu.top//parent.bottom
            bottomMargin: 1//24+textinput.height
            leftMargin: 8
            rightMargin: 4
            topMargin: 4
        }
        model: talk_model
        talkModel: talk_model
    }
    Rectangle{
        id:inputMenu
        color: BaseSettings.colorScheme_I
        radius: 4
        height: textinput.height+16
        anchors{
            bottom: isH ? toolBox.top : parent.bottom
            left: parent.left
            right: isH ? parent.right : toolBox.left
            bottomMargin: isH ? 0 : 1
            leftMargin: 1
            rightMargin: 1
        }
        Rectangle{
            id:audiobtn
            width: 32
            height: 32
            radius: width/2
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.bottom: textinput.bottom
            border.color: BaseSettings.accentcolor
            border.width: 2
            Image{
                width: parent.width*0.8
                height: width
                anchors.centerIn: parent
                source: "qrc:/Resources/Images/special/MicroChatListView/icons8_microphone_64px_1.png"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log(isH)
                }
            }
        }
        QcTextArea{
            id:textinput
            width: 200
            anchors.left: audiobtn.right
            anchors.leftMargin: 8
            anchors.right: sendbtn.left
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
        }
        Rectangle{
            id:sendbtn
            width: 62
            height: 36
            radius:4
            anchors.right: boxbtn.left
            anchors.rightMargin: 8
            anchors.bottom: textinput.bottom
            color: textinput.text.length>0 ? BaseSettings.accentcolor : BaseSettings.colorScheme_III
           Text{
               anchors.centerIn: parent
               text: "SEND"
               font.pixelSize: 14
               color: "#EEEEEE"
           }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(textinput.text.length>0){
                        tcpserver.sendTextMessage(textinput.text)
                        talk_model.appendText(true,1,0,textinput.text,false)
                        textinput.text=""
                    }
                }
            }
        }
        Rectangle{
            id:boxbtn
            width: 32
            height: 32
            radius: width/2
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.bottom: textinput.bottom
            border.color: BaseSettings.accentcolor
            border.width: 2
            Image{
                id:addimg
                width: parent.width*0.6
                height: width
                rotation: (toolBox.height ===0 || toolBox.width===0) ? 0 : 45
                anchors.centerIn: parent
                source: "qrc:/Resources/Images/special/MicroChatListView/icons8_plus_math_48px.png"
            }
            RotationAnimation{
                id:rotationAnimation
                target: addimg
                to: addimg.rotation===0 ? 45 : 0
                direction: RotationAnimation.Shortest
                easing.type: Easing.InOutExpo
                duration: 1000
            }
            PropertyAnimation {
                id:numberAnimation
                 target: toolBox
                 properties: isH ? "height" : "width"
                 to: {
                     if(isH){
                        return toolBox.height === 0 ? 200 : 0
                     }else{
                         return toolBox.width ===0 ? 256 : 0
                     }
                 }
                 duration: 1000
                 easing.type: Easing.InOutExpo
            }

            MouseArea{
                anchors.fill: parent
                onClicked:{
                     textinput.inputfocus=false
                     numberAnimation.start()
                     rotationAnimation.start()
                }
            }
        }
    }
    Rectangle{
        id:toolBox
        radius: 4
        height: isH ?  0 :  parent.height-2
        width: isH ?  parent.width-2 : 0
        anchors{
              bottom: parent.bottom
              right:  parent.right
              bottomMargin: 1
              rightMargin: 1
        }
        Loader{
            id:toolboxloader
            asynchronous: true
            anchors.fill: parent
            anchors.margins: 0
            sourceComponent: (toolBox.width < 128 || toolBox.height <100) ? undefined : toolboxcomponent
        }
        Component{
            id:toolboxcomponent
            ChatToolBox{}
        }
    }
}
