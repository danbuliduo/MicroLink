import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
Rectangle{
    id:root
    color:"#303030"
    property alias model:pathView.model
    property alias viewItem: pathView.delegate
    property alias viewpath: pathView.path
    property alias viewindex: pathView.currentIndex
    property int itemcount: 5
    PathView{
        id:pathView
        model:root.itemcount
        delegate:Item{
            id:delegateItem
            width: parent.width*0.3
            height: parent.height*0.8
            z:PathView.iconZ
            scale:PathView.iconScale
            QcGlowRectangle{
                id:itemRect
                width: delegateItem.width
                height: delegateItem.height
                color: "#EEEEEE"
                radius: 8
            }
            transform: Rotation{
                origin.x:itemRect.width/2.0
                origin.y:itemRect.height/4.0
                axis{x:0;y:1;z:0}
                angle: delegateItem.PathView.iconAngle
            }
        }
        path:Path{
            startX: 0
            startY: root.height/2
            PathAttribute{name:"iconZ";value: 0}
            PathAttribute{name:"iconAngle";value: 70}
            PathAttribute{name:"iconScale";value: 0.6}

            PathLine{x:root.width/2;y:root.height/2}

            PathAttribute{name:"iconZ";value: 100}
            PathAttribute{name:"iconAngle";value: 0}
            PathAttribute{name:"iconScale";value: 1.0}

            PathLine{x:root.width;y:root.height/2}

            PathAttribute{name:"iconZ";value: 0}
            PathAttribute{name:"iconAngle";value: -70}
            PathAttribute{name:"iconScale";value: 0.6}

            PathPercent{value:1.0}
        }
        pathItemCount: root.itemcount
        anchors.fill: parent
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
    }
}
