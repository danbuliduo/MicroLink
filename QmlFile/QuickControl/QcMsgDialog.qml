import QtQuick
import QtQuick.Controls

Item {
    id: root
    anchors.centerIn: parent
    property alias tiptext: msgtext.text
    property alias backcolor: backRect.color
    width: {
        if( msgtext.implicitWidth <= 120){
            return 120
        }else{
            return msgtext.implicitWidth > 300 ? 300 + 24 : (msgtext.implicitWidth + 24)
        }
    }
    height: msgtext.implicitHeight + 24 + 120

    Dialog {
        id: dialog
        width: root.width
        height: root.height
        modal: true
        closePolicy:Popup.NoAutoClose
        background: Rectangle {
            id:backRect
            color: "#FFFFFF"
            anchors.fill: parent
            radius: 5
        }
        header: Item{
            width: dialog.width
            height: 50
            Image {
                width: 40
                height: 40
                anchors.centerIn: parent
                source: "qrc:/QmlFile/QuickControl/img/exclamationpoint.png"
            }
        }
        contentItem: Item {
            Text {
                anchors.fill: parent
                anchors.centerIn: parent
                color: "gray"
                text: tiptext
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
        footer: Item {
            width: msgtext.width
            height: 50
            Button {
                anchors.centerIn: parent
                width: 80
                height: 40
                background: Rectangle {
                    anchors.centerIn: parent
                    width: 80
                    height: 40
                    radius: 5
                    border.color: "#0f748b"
                    border.width: 2
                    color: "#FFFFFF"
                    Text {
                        anchors.centerIn: parent
                        font.bold: true
                        color: "#0f748b"
                        text: "OK"
                        font.pixelSize: 14
                    }
                }
                onClicked: {
                    dialog.close();
                }
            }
        }
    }
    Text {
        id: msgtext
        visible: false
        width: 300
        wrapMode: Text.WordWrap
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    function open() {
        root.x = (parent.width - dialog.width) * 0.5
        root.y = (parent.height - dialog.height) * 0.5
        dialog.open()
    }
}
