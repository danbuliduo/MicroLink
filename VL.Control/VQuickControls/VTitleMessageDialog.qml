import QtQuick
import QtQuick.Controls
Dialog{
    id:root
    width: 320
    height: textMessage.implicitHeight+(buttonModel === VTitleMessageDialog.NoButton ? 80 :120)
    x: (parent.width - width) /2
    y: (parent.height - height) /2
    modal: true
    closePolicy:Popup.NoAutoClose
    property int buttonModel : VTitleMessageDialog.AllButton
    property alias titletext: textTitle.text
    property alias messagetext: textMessage.text
    property alias acceptedtext: acceptedButton.text
    property alias refusedtext: refusedButton.text
    property alias textTitle : textTitle
    property alias textMessage: textMessage
    property alias acceptedButton :acceptedButton
    property alias refusedButton: refusedButton
    signal accepted()
    signal refused()
    enum ButtonModel{
        NoButton,
        RefButton,
        AccButton,
        AllButton
    }
    background: Rectangle {
        id:backgroundRect
        color: "#FFFFFF"
        radius: 4
    }
    header: Item{
        height: 48
        Text{
            id:textTitle
            text: "Title"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 24
            font.bold: true
            font.pixelSize: 16
        }
        ToolButton{
            anchors.right: parent.right
            anchors.rightMargin: 8
            Image {
                source: "qrc:/VQuickControls/images/icons8_multiply_96px.png"
                width: 24
                height: 24
                anchors.centerIn: parent
            }
            onClicked: {
                root.close()
            }
        }
        Rectangle{
            width: parent.width
            height: 1
            color: "#CCCCCC"
            anchors.bottom: parent.bottom
        }
    }
    contentItem: Item {
        Text {
            id:textMessage
            anchors.fill: parent
            anchors.centerIn: parent
            color: "#808080"
            text: "Message: Hello World!"
            wrapMode: Text.WrapAnywhere
            verticalAlignment: Text.AlignVCenter
        }
    }
    footer: Item {
        height: 48
        visible: buttonModel !== VTitleMessageDialog.NoButton

        VPushButton{
            id:acceptedButton
            visible: buttonModel === VTitleMessageDialog.AccButton
                    ||  buttonModel === VTitleMessageDialog.AllButton
            width: 64
            height: 32
            radius: 2
            anchors.right: buttonModel === VTitleMessageDialog.AccButton ?
                                    parent.right : refusedButton.left
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 4
            text: "Ok"
            fontcolor: "#606060"
            onClicked: {
                root.accepted()
                root.close()
            }
        }
        VPushButton{
            id:refusedButton
            visible: buttonModel === VTitleMessageDialog.RefButton
                    ||  buttonModel === VTitleMessageDialog.AllButton
            width: 64
            height: 32
            radius: 2
            anchors.right: parent.right
            anchors.rightMargin: 32
            anchors.top: parent.top
            anchors.topMargin: 4
            text: "Cancle"
            fontcolor: "#606060"
            onClicked: {
                root.refused()
                root.close()
            }
        }
    }
}
