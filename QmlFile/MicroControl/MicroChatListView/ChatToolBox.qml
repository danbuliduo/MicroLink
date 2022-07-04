import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import "qrc:/QmlFile/AppSettings/"
Item{
    id:root
    property bool isH: rootAPP.height>rootAPP.width
    property int indexvalue : 0
    ListModel{
        id:listmodel
        ListElement {
            titlename: "图片"
            icourl: "qrc:/Resources/Images/special/MicroChatListView/icons8_image_file_add_64px.png"
        }
        ListElement {
            titlename: "GIF"
            icourl: "qrc:/Resources/Images/special/MicroChatListView/icons8_gif_48px.png"
        }
        ListElement {
            titlename: "音频"
            icourl: "qrc:/Resources/Images/special/MicroChatListView/icons8_audio_file_64px.png"
        }
        ListElement {
            titlename: "视频"
            icourl: "qrc:/Resources/Images/special/MicroChatListView/icons8_video_file_64px.png"
        }
        ListElement {
            titlename: "URL"
            icourl: "qrc:/Resources/Images/special/MicroChatListView/icons8_linked_file_64px_1.png"
        }
        ListElement {
            titlename: "文件"
            icourl: "qrc:/Resources/Images/special/MicroChatListView/icons8_folder_60px.png"
        }
    }
    SwipeView {
        id: view
        currentIndex: 0
        anchors.fill: parent
        clip:true
        Item{
            id: firstItem
            visible: indicator.currentIndex===0 ? true : false
            FileDialog{
                id:filedDialog
                onAccepted: {
                    switch(root.indexvalue){
                        case 0 : talk_model.appendImage(true,1,0,filedDialog.currentFile); break;
                        case 1 : talk_model.appendGIF(true,1,0,filedDialog.currentFile); break;
                        case 2 : talk_model.appendAudio(true,1,0,filedDialog.currentFile); break;
                        case 3 : talk_model.appendVideo(true,1,0,filedDialog.currentFile); break;
                        case 5 : talk_model.appendFile(true,1,0,filedDialog.currentFile); break;
                    }
                    console.log("filedDialog.currentFile",filedDialog.currentFile)
                }
            }
            Grid{
                anchors.top: parent.top
                anchors.topMargin: isH ? 16 : 16
                anchors.horizontalCenter: parent.horizontalCenter
                columnSpacing:  isH ? 48 : 32
                rowSpacing: isH ? 16 : 16
                rows:  isH ? 2 : 3
                columns:  isH ? 3 : 2
                Repeater{
                    model:listmodel
                    Rectangle{
                        id: itemtrc
                        width: 64
                        height: width
                        radius: 4
                        border.color: "grey"
                        Image{
                            anchors.top: parent.top
                            anchors.topMargin: 8
                            width: parent.width/2
                            height: width
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: icourl
                        }
                        Text{
                            text: titlename
                            color: "#606060"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 4
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                root.indexvalue=model.index
                                switch(root.indexvalue){
                                    case 0 : filedDialog.nameFilters=["Image files(*.JPG *.PNG *.SVG)"]; break;
                                    case 1 : filedDialog.nameFilters=["Image files(*.GIF)"];break;
                                    case 2 : filedDialog.nameFilters=["Audio files(*.MP3)"];break;
                                    case 3 : filedDialog.nameFilters=["Video files(*.MP4)"];break;
                                    case 4 : talk_model.appendText(true,1,0,"https://baidu.com",true); break;
                                    case 5 : filedDialog.nameFilters=["All files(*.*)"];break;
                                }
                                if(root.indexvalue!==4){
                                    filedDialog.open()
                                }
                            }
                        }
                    }
                }
            }
        }
        Item {
            id: secondItem
             visible: indicator.currentIndex===1 ? true : false
            Row{
            Button{
                text: "ALL"
                onClicked: {
                    talk_model.clearData()
                    debugsql.sql_Delete_Data("[Debug]")
                }
            }
            }
        }
        Item {
            id: thirdItem
             visible: indicator.currentIndex===2 ? true : false
            Text {
                text: qsTr("text")
                anchors.centerIn: parent
            }
        }
    }
    PageIndicator {
        id: indicator
        count: view.count
        currentIndex: view.currentIndex
        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        delegate: Rectangle{
            implicitWidth: 8
             implicitHeight: 8
             radius: 2
             color: index === indicator.currentIndex ? BaseSettings.accentcolor : BaseSettings.colorScheme_I
        }
    }
}
