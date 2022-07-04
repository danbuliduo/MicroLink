import QtQuick
import QtMultimedia

import "qrc:/QmlFile/QuickControl/"

Item {
    anchors.fill: parent
    Component.onCompleted: {
           console.log("InitCore=====Component.onCompleted=====")
    }
    property bool isH : width<height
    Item{
        id:imgitem
        width:320
        height: 320
        anchors.centerIn: parent
        Image {
            id:qt_view1
            anchors.fill: parent
            opacity: 1
            fillMode: Image.PreserveAspectFit
            source: "qrc:/Resources/Images/base/view1.png"
        }
        Image {
             id:qt_view2
            anchors.fill: parent
            opacity: 0
            fillMode: Image.PreserveAspectFit
            source: "qrc:/Resources/Images/base/view2.png"
        }
    }
    Text{
        id:title1_text
        anchors.top: parent.top
        anchors.topMargin: isH ? 32 : 32
        anchors.left: parent.left
        anchors.leftMargin: isH ? parent.width/3 : parent.width/6
        text: isH ? "万\n\n物\n\n互\n\n联" : "万  物  互  联"
        font.pixelSize: 18
        color: "#AAAAAA"
    }
    Text{
        id:title2_text
        anchors.top: parent.top
        anchors.topMargin: isH ? 96 : 96
        anchors.right: parent.right
        anchors.rightMargin: isH ? parent.width/3 : parent.width/6
        text: isH ? "面\n\n向\n\n未\n\n来" : "面  向  未  来"
        font.pixelSize: 18
        color: "#AAAAAA"
    }
    Text{
        id:app_name_text
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: imgitem.top
        anchors.topMargin: parent.width>parent.height ? imgitem.height/2 : 32+imgitem.height
        text:parent.width>parent.height ? "We                            Link" : "We  Link"
        font.bold: true
        font.pixelSize: 40
        font.family: "Carrois Gothic SC"
        font.italic:true
        color: "#AAAAAA"
    }
    QcGraText{
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.bottom: parent.bottom
         anchors.bottomMargin:parent.width>parent.height ? 50 : 80
         text:"博学    博爱     立人     达人"
         objduration: 3600
         scolor: "#080A16"
         ecolor: "#FFFFFF"
         font.pixelSize: 24
    }
    Text{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        text:"版权所有 © 湖北民族大学 D.Ming    All Right Reserved"
        color:"grey"
        font.pixelSize: 10
    }
    MediaPlayer{
        id:mediaplayer_appinit
        source: ""
        audioOutput: AudioOutput{}
    }
    NumberAnimation{
        id:qtviewInitAnimation
        running: true
        duration: 1200
        onStopped: {
            qtviewRunAnimation.start()
        }
    }
    ParallelAnimation{
        id:qtviewRunAnimation
        PropertyAnimation{
            target: qt_view1
            property: "opacity"
            duration: 800
            from: 1
            to:0
        }
        PropertyAnimation{
            target: qt_view2
            property: "opacity"
            duration: 800
            from: 0
            to:1
        }
    }
    ParallelAnimation{
        id:titletextRunAnimation
        running: true
        PropertyAnimation{
            target: title1_text
            property: "anchors.topMargin"
            duration: 2000
            easing.type: Easing.OutInSine
            from: 32
            to:96
        }
        PropertyAnimation{
            target: title2_text
            property: "anchors.topMargin"
            duration: 2000
            easing.type:Easing.OutInSine
            from: 96
            to:32
        }
    }
    Component.onDestruction: {
           console.log("InitCore=====Component.onDestruction=====")
    }
}
