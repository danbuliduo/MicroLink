import QtQuick
import QtQuick.Controls

TextEdit {
    id: root
    property int textWidth: private_text.implicitWidth
    padding: 6
    font{
        pixelSize: 14
    }
    verticalAlignment: TextEdit.AlignVCenter
    horizontalAlignment: TextEdit.AlignLeft
    readOnly: true

    selectByMouse: false
    selectionColor: "black"
    selectedTextColor: "white"

    wrapMode: TextEdit.WrapAnywhere

    Text{
        id: private_text
        visible: false
        font: root.font
        padding: root.padding+2
        text: root.text
    }
}
