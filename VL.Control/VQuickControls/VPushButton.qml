import QtQuick
import QtQuick.Controls
AbstractButton{
   id:root
   width: 64
   height: 32
   text: "Button"
   display:AbstractButton.TextOnly
   property alias fontcolor: text.color
   property alias backcolor: backgroundRect.color
   property alias bordercolor: backgroundRect.border.color
   property alias radius: backgroundRect.radius
   property alias backgroundRect: backgroundRect
   background: Rectangle{
       id: backgroundRect
       color: root.pressed ? "#EEEEEE" :"#FFFFFF"
       border.color: root.pressed ? "#AAAAAA" :"#CCCCCC"
       radius:2
   }
   contentItem: Text{
       id:text
       text: root.text
       font: root.font
       horizontalAlignment: Text.AlignHCenter
       verticalAlignment: Text.AlignVCenter
       elide: Text.ElideRight
   }
}
