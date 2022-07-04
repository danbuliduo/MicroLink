import QtQuick
import QtQuick.Controls
Item {
    id:root
    width: 64
    height: 36
     property string thisname : "Lable"
    Connections {
        target: eitlinkcore
        function onCubeDataSink (ObjName,JSONData){
             if(ObjName===thisname){
                 console.log(JSONData)
                 var JS_Data = JSON.parse(JSONData)
                 if(JS_Data.DATA){
                     labletext.text=JS_Data.DATA
                 }
             }
        }
    }
    Text{
        id:labletext
        anchors.centerIn: parent
        text: "LABLE"
    }
}
