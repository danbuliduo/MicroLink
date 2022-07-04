import QtQuick
Rectangle{
    id:root
    width: 200
    height: 200
    property alias topleftVisible: topleft.visible
    property alias toprightVisible: topright.visible
    property alias bottomrightVisible: bottomright.visible
    property alias bottomleftVisible: bottomleft.visible
    Rectangle{
        id:topleft
        anchors.top: parent.top
        anchors.left: parent.left
        color: parent.color
        visible: false
        width: parent.radius
        height: width
    }
    Rectangle{
        id:topright
        anchors.top: parent.top
        anchors.right: parent.right
        color: parent.color
        visible: false
        width: parent.radius
        height: width
    }
    Rectangle{
        id:bottomright
        anchors.bottom:  parent.bottom
        anchors.right: parent.right
         color: parent.color
        visible: true
        width: parent.radius
        height: width
    }
    Rectangle{
        id:bottomleft
        anchors.bottom:  parent.bottom
        anchors.left: parent.left
         color: parent.color
        visible: false
        width: parent.radius
        height: width
    }
}
