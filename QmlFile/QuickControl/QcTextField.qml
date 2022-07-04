import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
TextField {
    id:root
    implicitHeight: 32    // 确保不同平台高度一致
    implicitWidth: 100
    bottomPadding: (root.height-font.pixelSize)/2-4    // 文本框高度为32
    leftPadding: 6
    rightPadding: 6
    Material.accent: Material.foreground
    selectByMouse: true
    background: Rectangle{
        property color hovered: Qt.lighter(Material.background, 1.25)
        border.color: parent.activeFocus ? Material.background : parent.hovered ? hovered : Qt.lighter(hovered, 1.25)
    }
    onAccepted: {
        root.focus=false
    }
}
