import QtQuick
import QtQuick.Controls
import QtMultimedia
import "qrc:/QmlFile/QuickControl/"
import sys.filestream 1.0
ChatItemBase{
    id:root
    Component.onCompleted:
    {
        titletext.text=FileStream.getFileName(model.videourl)
        sizetext.text=FileStream.getFileSize(model.videourl)

        /*readaudiodata(mediaplayer.metaData)
        readaudiodata(mediaplayer.audioTracks[mediaplayer.activeAudioTrack])
        for(var x=0;x<audiodataModel.count;x++){
            console.log(audiodataModel.get(x).name,audiodataModel.get(x).value)
            if(audiodataModel.get(x).name==="Title"){
                titletext.text=audiodataModel.get(x).value
            }else if(audiodataModel.get(x).name==="Audio bit rate"){
                //batetext.text=(audiodataModel.get(x).value/1024/1024).toFixed(2).toString()+"MB"
            }
        }*/
    }
    property bool isplay: false
    Row{
        width: root.contentWidth
        x:root.isUser ? root.width -timelable.width-root.usernameWidth-root.rightWidth -8
                            : root.sendernameWidth-root.leftWidth+8
        ChatLabel{
            id:timelable
            text:model.dateTime
            padding: 0
            font.pixelSize: 12
        }
    }
    Row{
        width: root.contentWidth
        layoutDirection: root.isUser ? Qt.RightToLeft : Qt.LeftToRight
        Rectangle{
            id:itemrec
            height: 100
            width: 200
            radius: 6
            ListModel{
                id:audiodataModel
            }
            MediaPlayer{
                id: mediaplayer
                source:model.videourl
                audioOutput: AudioOutput {}
            }
           Frame{
               id:logorec
                width: height
                height: itemrec.height/2
                anchors.top: parent.top
                anchors.topMargin: 16
                anchors.left: parent.left
                anchors.leftMargin: 16
                Image{
                    anchors.fill: parent
                    source: "qrc:/Resources/Images/special/MicroChatListView/icons8_music_64px.png"
                }
           }
           Text{
                id:titletext
                anchors.left: logorec.right
                anchors.leftMargin: 8
                anchors.top: logorec.top
           }
           Text{
               id:sizetext
               anchors.left: logorec.right
               anchors.leftMargin: 8
               anchors.bottom: centerow.top
               anchors.bottomMargin: -2
           }
            Row{
                id:centerow
                anchors.left: logorec.right
                anchors.leftMargin: 8
                anchors.bottom: logorec.bottom
                anchors.bottomMargin: -8
                Text{
                    id:speedtext
                    text: "倍速:" + speedslider.value.toFixed(1) + "x"
                    color: "#606060"
                    font.pixelSize: 10
                    anchors.verticalCenter: parent.verticalCenter
                }
                QcSlider{
                    id:speedslider
                     implicitWidth :itemrec.height*0.6
                     anchors.verticalCenter: parent.verticalCenter
                    snapMode: Slider.SnapOnRelease
                    from: 0.5
                    to: 2.5
                    stepSize: 0.5
                    value: 1.0
                    handlerecradius: 2
                    handlerecheight: 8
                    handlerecwidth:8
                    completeColor:"#BBBBBB"
                    onValueChanged:{
                        mediaplayer.setPlaybackRate(value)
                        mediaplayer.play()
                        root.isplay=true
                    }
                }
            }

            Rectangle{
                border.width: 1
                border.color: "grey"
                width: 20
                height: 20
                radius: width/2
                anchors.right: bottomrow.right
                anchors.bottom: logorec.bottom
                anchors.bottomMargin: -width*0.3
                Image{
                    id:isplayimg
                    width: parent.width*0.9
                    height: width
                    anchors.centerIn: parent
                    source: root.isplay ? "qrc:/Resources/Images/special/MicroChatListView/icons8_pause_64px.png"
                                                 : "qrc:/Resources/Images/special/MicroChatListView/icons8_play_64px.png"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        root.isplay ? mediaplayer.pause() : mediaplayer.play()
                        root.isplay=!root.isplay
                    }
                }
            }

            Row{
                id:bottomrow
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    color: "grey"
                    text: {
                        var m = Math.floor(mediaplayer.position / 60000)
                        var ms = (mediaplayer.position / 1000 - m * 60).toFixed(1)
                        return `${m}:${ms.padStart(4, 0)}`
                    }
                }
                QcSlider{
                    id:playsider
                    width: itemrec.width*0.75
                    enabled: mediaplayer.seekable
                    to: 1.0
                    value: mediaplayer.position / mediaplayer.duration
                    onMoved: {
                        mediaplayer.setPosition(value*mediaplayer.duration)
                    }
                }
            }
        }
    }
    function readaudiodata(metadata){
        if (metadata) {
            for (var key of metadata.keys()) {
                if (metadata.stringValue(key)) {
                    audiodataModel.append({
                        name: metadata.metaDataKeyToString(key) ,
                        value: metadata.stringValue(key)
                    })
                }
            }
        }
    }
}
