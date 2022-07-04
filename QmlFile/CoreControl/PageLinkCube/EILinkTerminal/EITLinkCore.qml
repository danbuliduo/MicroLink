import QtQuick
import QtQuick.Controls
import "qrc:/QmlFile/MicroControl/MicroLinkCube/"
import lps.link.chip 1.0
import sys.android.notification 1.0
Rectangle{
   property alias eitCoreModel : listRepeaterModel
   signal cubeDataSink(string objname,string jsondata)
   signal cubeImageSink
   function cubeDataSend(data){
       linkzeroCHIP.sendTextMessage(data)
   }
   LinkZeroCHIP{
       id:linkzeroCHIP
       onCallJsonDataSink: function(ObjName,JSONData){
           cubeDataSink(ObjName,JSONData)
       }
       onCallIMGDataSink:{
           cubeImageSink()
       }
       onCallNewConnect: function(ip,port){
            AndroidNotifiCation.setNotification("New Link\n[IP: "+ip+"  端口: "+port+"]")
            linkzeroCHIP.sendTextMessage("@vlian.io [Welcome To WeLink!]")
       }
       onCallDisConnect: function(ip,port){
           AndroidNotifiCation.setNotification("Dis Link\n[IP: "+ip+"  端口: "+port+"]")
       }
   }

    Flickable{
       anchors.fill: parent
       anchors.margins: parent.border.width
       contentWidth: isV ? width :width*2
       contentHeight: isV ? height*2 : height
       clip: true
       Repeater{
           id:rootRepeater
           model:ListModel {
               id: listRepeaterModel
           }
           delegate:Loader{
               id:eitLoader
               asynchronous: true
               visible: status === Loader.Ready
               sourceComponent:{
                   if(OBJ_ID==="OFGC-001"){
                       return obj_MicroChartView
                   }else if(OBJ_ID==="OFGC-002"){
                       return obj_MicroButton
                   }else if(OBJ_ID==="OFGC-003"){
                       return obj_MicroLable
                   }else if(OBJ_ID==="OFGC-004"){
                       return obj_MicroImageFrame
                   }
               }
               x:OBJ_X
               y:OBJ_Y
               width: OBJ_Width
               height: OBJ_Height
               Drag.active: mousearea.drag.active
               MouseArea{
                   id:mousearea
                   visible: loader_Box.sourceComponent !== undefined
                   anchors.fill: parent
                   drag.target: parent
                   pressAndHoldInterval: 1500
                   propagateComposedEvents: true
                   onClicked: function(mouse){
                       console.log("Clicked")
                       mouse.accepted = false
                   }
                   onReleased:  {
                       console.log("Released")
                       OBJ_X=parent.x
                       OBJ_Y=parent.y
                   }
                   onPressAndHold:{
                       console.log("PressAndHold")
                       listRepeaterModel.remove(index)
                   }
               }
           }
       }
       Component{
           id:obj_MicroChartView
           MicroChartView {
               anchors.fill: parent
           }
       }
       Component{
           id:obj_MicroButton
           MicroButton {
               anchors.fill: parent
           }
       }
       Component{
           id:obj_MicroLable
           MicroLable {
               anchors.fill: parent
           }
       }
       Component{
           id:obj_MicroImageFrame
           MicroImageFrame{
               anchors.fill: parent
           }
       }
   }
}
