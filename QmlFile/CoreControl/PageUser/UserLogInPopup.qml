import QtQuick
import QtQuick.Controls
Dialog{
    id:root
    width: 320
    height: 280
    x:(rootAPP.width-width)/2
    y:(rootAPP.height-height-rootAPP.footer.height-rootAPP.header.height)/2
    modal: true
    closePolicy: Popup.NoAutoClose
    background: Rectangle{
        radius: 4
    }
    header: Item{
        height: 100
        ToolButton{
            anchors.right: parent.right
            Image{
                width: 24
                height: 24
                anchors.centerIn: parent
                source: "qrc:/Resources/Images/icon/icons8_multiply_48px.png"
            }
            onClicked: {
                root.close()
            }
        }
        Text {
            text: "WeLink"
            color: "#606060"
            font.pixelSize: 18
            font.family: "Agency FB"
            font.bold: true
            anchors.top: parent.top
            anchors.topMargin: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Image{
            width: 64
            height: 64
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            source: "qrc:/Resources/Images/debug/BUG.png"
        }
    }
}
