import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Templates  as T

T.ComboBox {
    id: root
    implicitWidth: implicitBackgroundWidth;
    implicitHeight: implicitBackgroundHeight;
    leftPadding: padding + (!root.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing);
    rightPadding: padding + (root.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing);

    // 可在此定义多为改变的特殊属性，在调用时直接指定此属性即可
    font.pointSize: 12
    model: ListModel
    property color fontcolor: "#808080" // 字体颜色
    property color backcolor: "#BBBBBB" // 背景色

    // 弹出框行委托
    delegate: ItemDelegate {
        width: parent.width
        height: 30
        // 行字体样式
        contentItem: Text {
            text: key
            font: root.font
            color: root.fontcolor
            elide: Text.ElideRight
            verticalAlignment: Text.AlignHCenter
            renderType: Text.NativeRendering
        }
        palette.text: root.palette.text;
        palette.highlightedText: root.palette.highlightedText;
        font.weight: root.currentIndex === index ? Font.DemiBold : Font.Normal;
        highlighted: root.highlightedIndex === index;
        hoverEnabled: root.hoverEnabled;
    }
    // 右侧下拉箭头
    indicator: Canvas {
        id: canvas
        x: root.width - width - root.rightPadding;
        y: root.topPadding + (root.availableHeight - height) / 2
        width: 12
        height: 6
        contextType: "2d"
        Connections{
            target: root
        }
        onPaint: {
            context.reset()
            context.moveTo(0, 0)
            context.lineWidth = 2
            context.lineTo(width / 2, height*0.8)
            context.lineTo(width, 0)
            context.strokeStyle =  "#808080"
            context.stroke()
        }
    }
       //ComboBox文字位置样式
        contentItem: T.TextField {
        leftPadding: !root.mirrored ? 12 : root.editable && activeFocus ? 3 : 1
        rightPadding: root.mirrored ? 12 : root.editable && activeFocus ? 3 : 1
        topPadding: 6 - root.padding
        bottomPadding: 6 - root.padding
        text: root.editable ? root.editText : root.displayText
        enabled: root.editable
        autoScroll: root.editable
        readOnly: root.down
        inputMethodHints: root.inputMethodHints
        validator: root.validator
        font: root.font
        color: root.fontcolor
        selectionColor: root.palette.highlight
        selectedTextColor: root.palette.highlightedText
        verticalAlignment: Text.AlignVCenter
        renderType: Text.NativeRendering
        background: Rectangle {
            visible: root.enabled && root.editable && !root.flat
            border.width: parent && parent.activeFocus ? 2 : 1
            border.color: parent && parent.activeFocus ? root.palette.highlight : root.palette.button
            color: root.palette.base
        }
    }

    // ComboBox背景样式
    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 30
        radius: 2
        color: root.enabled ? "#FFFFFF" : root.backcolor
        border.color: root.backcolor
        border.width: !root.editable && root.visualFocus ? 2 : 1
        visible: !root.flat || root.down
    }
    //弹出窗口样式
    popup: T.Popup {
        y: root.height
        width: root.width
        height: contentItem.implicitHeight
        topMargin: 3
        bottomMargin: 3
        contentItem: ListView {
            boundsBehavior: Flickable.StopAtBounds
            implicitHeight: contentHeight
            model: root.delegateModel
            currentIndex: root.highlightedIndex
            highlightMoveDuration: 0
            Rectangle {
                z: 10
                width: parent.width
                height: parent.height
                color: "transparent"
                border.color: root.palette.mid
            }
            T.ScrollIndicator.vertical: ScrollIndicator { }
        }
        background: Rectangle {
            color: "#FFFFFF"
            border.width: 1
            border.color: root.backcolor
            radius: 2
        }
    }
}
