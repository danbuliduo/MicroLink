import QtQuick

Flipable {
    id: root
    property bool flipped: true
    property int xAxis: 0
    property int yAxis: 1
    property int angle: 180
    width: front.width
    height: front.height
    state: "back"

    transform: Rotation {
        id: rotation
        origin.x: root.width / 2
        origin.y: root.height / 2
        axis.x: root.xAxis
        axis.y: root.yAxis
        axis.z: 0
    }

    states: [
        State {
            name: "back";
            when: root.flipped
            PropertyChanges {
                target: rotation
                angle: root.angle
            }
        }
    ]

    transitions: Transition {
        SequentialAnimation {
            ParallelAnimation{
                NumberAnimation {
                    target: root
                    property: "scale"
                    to: 0.88
                    duration: 100
                }
                NumberAnimation {
                    target: root
                    property: "opacity"
                    to:0.7
                    duration: 100
                    easing.type: Easing.Linear
                }
            }

            ParallelAnimation {
                NumberAnimation {
                    target: root;
                    property: "scale"
                    to: 0.75
                    duration: 120
                }
                NumberAnimation {
                    target: rotation;
                    properties: "angle"
                    duration: 380
                }
                NumberAnimation {
                    target: root;
                    property: "opacity"
                    to:0.4
                    duration: 280
                    easing.type: Easing.Linear
                }
            }

            ParallelAnimation{
                NumberAnimation {
                    target: root
                    property: "scale"
                    to: 1.0
                    duration: 160
                }
                NumberAnimation {
                    target: root
                    property: "opacity"
                    to:1.0
                    duration: 160
                    easing.type: Easing.Linear
                }
            }
        }
    }
    function startOverturn(){
        root.flipped ^= 1
    }
}
