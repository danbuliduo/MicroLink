import QtQuick
import QtQuick.Controls
import  QtMultimedia
import Qt5Compat.GraphicalEffects

import "qrc:/QmlFile/AppSettings/"
import "qrc:/QmlFile/QuickControl/"

QcArrowsPopop{
    id:root
    x: rootAPP.width-width-6
    y:18
    width: 160
    height: isV ? 260 : 200
    backradius: 4
    arrowssize: 14
    arrowmargin: 14
    arrowmodel: 1
    enter: Transition {
        PropertyAnimation {
            duration: 500
            easing.type: Easing.OutBounce
            property: 'scale'
            from: 0
            to: 1
        }
    }
    Loader{
        anchors.fill: parent
        asynchronous: true
        visible: status == Loader.Ready
        sourceComponent: root.visible ? component_ToolCard : undefined
    }
    Component{
        id:component_ToolCard
        ListView{
            id:listview
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
                bottom:parent.bottom
                leftMargin: 10
                rightMargin: 10
                topMargin: 4
                bottomMargin: 10
            }
            focus: true
            clip: true
            model:ListModel{
                id:popoplist
                ListElement{
                    imgurl:"qrc:/Resources/Images/icon/icons8_add_user_male_64px.png"
                    txt:"添加WL用户"
                }
                ListElement{
                    imgurl:"qrc:/Resources/Images/icon/icons8_organization_48px.png"
                    txt:"创建WL组织"
                }
                ListElement{
                    imgurl:"qrc:/Resources/Images/icon/icons8_qr_code_48px.png"
                    txt:"UID QR码"
                }
                ListElement{
                    imgurl:"qrc:/Resources/Images/icon/icons8_sanning_64px.png"
                    txt:"Micro扫码"
                }
                ListElement{
                    imgurl:"qrc:/Resources/Images/icon/icons8_web_design_64px.png"
                    txt:"体系架构"
                }
                ListElement{
                    imgurl:"qrc:/Resources/Images/icon/icons8_book_48px.png"
                    txt:"开发文档"
                }
            }
            delegate: ItemDelegate{
                width: listview.width
                height: isV ? listview.height/5 : listview.height/4
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10
                    Image{
                        width: 24
                        height: width
                        source: imgurl
                        ColorOverlay{
                            anchors.fill: parent
                            source: parent
                            color:BaseSettings.colorScheme_VII
                        }
                    }
                    Text{
                        text:txt
                        font.pixelSize: 14
                        color: "#363636"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                onClicked: {
                    console.log(index)
                }
            }
        }
    }

    MediaPlayer{
        id:mediaplayer
        source: "qrc:/Resources/Medias/Audio/popop1.mp3"
        audioOutput: AudioOutput{}
    }
    function show(){
        root.open()
        if(BaseSettings.openSoundeffect){
            mediaplayer.play()
        }
    }
}
