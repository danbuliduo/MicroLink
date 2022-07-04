import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Templates as T

T.Slider {
    id: root

    property color handleBorderColor: "#808080"     //按钮边框颜色
    property color handleNormalColor: "#FAFAFA"  //按钮颜色
    property color handleHoverColor: "#DDDDDD"
    property color handlePressColor: "#CCCCCC"
    property color completeColor: "#B4BCD6"
    property color incompleteColor: "#E0E0E0"
    property double backgroundradius: 4
    property alias handlerecradius: handlerec.radius
    property alias handlerecwidth: handlerec.width
    property alias handlerecheight: handlerec.height

    implicitWidth: horizontal? 200: 24
    implicitHeight: horizontal? 24: 200

    padding: horizontal? height/4: width/4

    handle: Rectangle {
        id:handlerec
        x: root.leftPadding + (root.horizontal ? root.visualPosition * (root.availableWidth - width) : (root.availableWidth - width) / 2)
        y: root.topPadding + (root.horizontal ? (root.availableHeight - height) / 2 : root.visualPosition * (root.availableHeight - height))
        width: root.horizontal?(root.height/2):(root.width/2)
        height:width
        radius: width/2
        color: root.pressed ?handlePressColor :root.hovered
                                     ?handleHoverColor :handleNormalColor
        border.width: 1
        border.color: handleBorderColor
    }

    background: Rectangle {
        x: root.leftPadding + (root.horizontal ? 0 : (root.availableWidth - width) / 2)
        y: root.topPadding + (root.horizontal ? (root.availableHeight - height) / 2 : 0)
        implicitWidth: root.horizontal ? 200 : 6
        implicitHeight: root.horizontal ? 6 : 200
        width: root.horizontal ? root.availableWidth : implicitWidth
        height: root.horizontal ? implicitHeight : root.availableHeight
        radius: root.backgroundradius
        color: root.incompleteColor
        scale: root.horizontal && root.mirrored ? -1 : 1

        Rectangle {
            y: root.horizontal ? 0 : root.visualPosition * parent.height
            width: root.horizontal ? root.position * parent.width : parent.width
            height: root.horizontal ? parent.height : root.position * parent.height
            radius: root.backgroundradius
            color: root.completeColor
        }
    }
}
