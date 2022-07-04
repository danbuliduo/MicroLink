import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtMultimedia

import "qrc:/QmlFile/AppSettings/"
import "qrc:/QmlFile/OpenLib/QMLQRCodeJS"
import "qrc:/QmlFile/QuickControl/"
import "qrc:/QmlFile/MicroControl/MicroChatListView/"
import mcv.photostudio 1.0
import model.linkmodel
Item {
    /*MLPhotoStudio{
        id:ps
        onCallQmlRefeshImg: {
            img.source = "image://microImageProvider/0"
            img.source = "image://microImageProvider/1"
        }
    }
     FileDialog{
         id:filed
         nameFilters: ["Image Files(*.jpg *.png *.svg)"];
         onAccepted: {
             img.source=filed.currentFile
             ps.getPath(filed.currentFile)
         }
     }
     Column{
     Button{
         width: 100
         height: 100
         background: Rectangle{

         }
         onClicked: {
             filed.open()
         }

     }
     Image {
         id:img
         cache: false
         asynchronous: true
         sourceSize: Qt.size(100,100)
         width: 100
         height: 100
         fillMode: Image.PreserveAspectFit
     }
     }
    QRCode{
        id:qrcode
        visible: true
        anchors.top : parent.top
        anchors.topMargin : 10
        anchors.right: parent.right
        width : 200
        height : 200
        value : "MicroLink"
        level : "Q"
        foreground:BaseSettings.accentcolor
        background: "#FFFFFF"
    }
    QcQTStyleLable{
        anchors.centerIn: parent
    }*/
    MicroChatListViewCore{
        anchors.fill: parent
    }
}
