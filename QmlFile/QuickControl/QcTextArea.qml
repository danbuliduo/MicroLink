import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
Item{
    id:root
    height: textArea.implicitHeight >=maxheight ? maxheight : textArea.implicitHeight
    width: 200

    property alias inputfocus: textArea.focus
    property alias text: textArea.text
    property alias textAreaimplicitHeight:textArea.implicitHeight
    property double maxheight : 128

    ScrollView{
        width: parent.width
        height: parent.height
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        clip: true
        ListView {
            model: 1
            width: 0
            delegate: Item{
               width: 0
               height: textArea.implicitHeight
            }
        }
        TextArea {
            id:textArea
            bottomPadding: 8
            leftPadding: 4
            rightPadding: 4
            font{
               pixelSize: 14
            }
            Material.accent: Material.foreground
            wrapMode:TextEdit.Wrap
             verticalAlignment: Text.AlignTop
             placeholderText: "$INPUT:\\"
             color: "#606060"
             background: Rectangle{
                 color: "#FAFAFA"
                 border.color: "grey"
                 radius: 4
            }
        }
    }
}
