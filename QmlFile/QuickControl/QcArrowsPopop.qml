import QtQuick
import QtQuick.Controls
Popup{
    id:root
    width: 120
    height: 200
    x:(parent.width-width)/2
    y:(parent.height-height)/2
    modal: true
    focus: true
    closePolicy: Popup.CloseOnPressOutside
    Component.onCompleted: {
        switch(arrowmodel){
            case 0:arrowrec.x=(root.width-arrowrec.width)/2 ; break
            case 1:arrowrec.x=(root.width-arrowrec.width-arrowmargin) ; break
        }
    }
    property color color: "#FFFFFF" //颜色
    property int arrowmodel: 0 //箭头位置模型
    property double arrowmargin: 10 //相对距离
    property alias backradius : backrec.radius //边角
    property alias arrowssize: arrowrec.width //箭头大小
    property alias havearros: arrowrec.visible //是否显示箭头
    background: Rectangle{
        id:backrec
        color: root.color
        Rectangle{
            id:arrowrec
            y:-(height-1)/2
            x:(parent.width-width)/2
            width: 16
            height: 16
            color: root.color
            rotation: -45
        }
    }

}
