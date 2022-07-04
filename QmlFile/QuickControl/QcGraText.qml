import QtQuick
Text{
    id:root
    font.pixelSize: 20
    color: scolor
    property color scolor: "white"
    property color ecolor: "black"
    property int objduration: 1000
    SequentialAnimation on color {
        loops: Animation.Infinite
        ColorAnimation {
            duration: root.objduration
            from: root.scolor
            to: root.ecolor
        }
        ColorAnimation {
            duration: root.objduration
            from: root.ecolor
            to: root.scolor
        }
    }
}
