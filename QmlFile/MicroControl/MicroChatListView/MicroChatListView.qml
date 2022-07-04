import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

import model.chatmodel 1.0

ListView {
    id: control

    property ChatListModel talkModel

    clip: true

    headerPositioning: ListView.OverlayHeader
    footerPositioning: ListView.OverlayFooter
    boundsBehavior: Flickable.StopAtBounds

    highlightFollowsCurrentItem: true
    highlightMoveDuration: 0
    highlightResizeDuration: 0

    spacing: 16

    delegate: Loader{
        asynchronous: true
        visible: status == Loader.Ready
        sourceComponent: {
            switch(model.type){
                case ChatData.Text:
                    return text_comp
                case ChatData.Image:
                    return image_comp
                case ChatData.GIF:
                    return gif_comp
                case ChatData.Audio:
                    return audio_comp
                case ChatData.Video:
                    return  video_comp
                case ChatData.File:
                    return file_comp
            }
            return none_comp;
        }

        Component{
            id: text_comp
            ChatItemText{}
        }
        Component{
            id:image_comp
            ChatItemImage{}
        }
        Component{
            id:gif_comp
            ChatItemGIF{}
        }
        Component{
            id:audio_comp
            ChatItemAudio{}
        }

        Component{
            id:video_comp
            ChatItemVideo{}
        }
        Component{
            id:file_comp
            ChatItemFile{}
        }

        Component{
            id: none_comp
            Item{ }
        }
    }


    header: Item{
        height: 10
    }
    footer: Item{
        height: 10
    }

    ScrollBar.vertical: ScrollBar {
        id: scroll_vertical
        width: 4
        contentItem: Item{
            visible: (scroll_vertical.size<1.0)
            width: 4
            Rectangle{
                anchors.centerIn: parent
                radius: 0
                width:4
                height: parent.height>20 ? parent.height : 20
                color: (scroll_vertical.hovered || scroll_vertical.pressed) ? Qt.darker("#A4ACC6") : "#A4ACC6"
            }
        }
    }
}

