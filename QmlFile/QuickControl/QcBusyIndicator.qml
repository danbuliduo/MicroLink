import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
BusyIndicator{
        id: root
        implicitWidth: 40
        implicitHeight: 40
        running: true
        property color startcolor: "#43CBFF"
        property color endcolor: "#9708CC"
        property alias objduration: rotAni.duration
        contentItem: Item {
            Rectangle {
                id: rect
                width: parent.width
                height: parent.height
                color: "transparent"
                radius: width / 2
                border.width: width / 6
                visible: false
            }
            ConicalGradient {
                width: rect.width
                height: rect.height
                gradient: Gradient {
                    GradientStop { position: 0.0; color: root.startcolor }
                    GradientStop { position: 1.0; color: root.endcolor }
                }
                source: rect
                Rectangle {
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: rect.border.width
                    height: width
                    radius: width / 2
                    color: root.startcolor
                }
                RotationAnimation on rotation {
                    id:rotAni
                    from: 0
                    to: 360
                    duration: 1000
                    loops: Animation.Infinite
                }
            }
        }
}
