import QtQuick
import QtQuick.Controls
Rectangle{
     id:root
     width: 120
     height: width
     color: "#EEEEEE"
     border.color: "#808080"
     radius: width/2
     property alias  btnsize: rect.width
     property alias  bordcolor: rect.border.color
     property alias  bordwidth: rect.border.width
     property alias  rectsize: rect.width
     property alias  rectcolor: rect.color
     readonly property double diskR: root.width/2
     readonly property double centerX : rect.x+rect.width/2
     readonly property double centerY : rect.y+rect.height/2
     readonly property double moveX: Math.abs(root.diskR-root.centerX)
     readonly property double moveY: Math.abs(root.diskR-root.centerY)
     readonly property double minY: root.diskR-Math.sqrt(root.diskR*root.diskR-root.moveX*root.moveX )
     readonly property double maxY: root.diskR+Math.sqrt(root.diskR*root.diskR-root.moveX*root.moveX)
     readonly property double minX: root.diskR-Math.sqrt(root.diskR*root.diskR-root.moveY*root.moveY )
     readonly property double maxX: root.diskR+Math.sqrt(root.diskR*root.diskR-root.moveY*root.moveY)
     readonly property double value: Math.atan((root.centerX-root.diskR)/root.returnvalue(root.centerY-root.diskR))*2/Math.PI
     Rectangle{
         id:rect
         width: 40
         height: width
         y:root.height-height
         x:root.width-width
         radius: width/2
         border.color: "#BBBBBB"
         Drag.active: dragArea.drag.active
         NumberAnimation on x{
             id:xani
             duration: 500
             easing.type: Easing.OutCubic
             to:(root.height-rect.height)/2
         }
         NumberAnimation on y{
             id:yani
             duration: 500
             easing.type: Easing.OutCubic
             to:(root.width-rect.width)/2
         }
         MouseArea{
             id: dragArea
             anchors.fill: parent
             drag.target: parent
             drag.maximumY:root.maxY-rect.height/2
             drag.maximumX:root.maxX-rect.width/2
             drag.minimumY: root.minY-rect.width/2
             drag.minimumX:root.minX-rect.width/2
             onPositionChanged: {
                 console.log(root.value)
             }
             onReleased: {
                 xani.start()
                 yani.start()
             }
         }
     }
     function returnvalue(num){
         //MAX1.7976931348623157e+308 MIN5e-324
         if(num>=0&&num<1.0e-305){return 1.0e-305}
         else if(num>=-1.0e-305&&num<0){ return -1.0e-305 }
         return num
     }
     function returnangle(x,y,num){
     }
}
