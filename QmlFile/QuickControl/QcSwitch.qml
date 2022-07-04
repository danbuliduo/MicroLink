import QtQuick
import QtQuick.Controls
Switch {
      id: root
      text: ""
      property string checkedtext : ""
      property double backwidth:48
      property double backheight: 24
      property int objduration: 200
      property int fontsize: 16
      property bool fontbold: false
      property color fontcolorIsC : "#000000"                //字体色(1)
      property color fontcolorNoC : "#000000"             //字体色(0)
      property color backReccolorIsC : "#00AE9D"        //背景色(1)
      property color backReccolorNoC : "#DDDDDD"   //背景色(0)
      property color switchBtncolorIsC: "#FFFFFF"       //按钮色(1)
      property color switchBtncolorNoC: "#FFFFFF"     //按钮色(0)
      property color switchBtnbordercolor : "#AFDFE4"//按钮边色
      indicator: Rectangle {
          id:backrec
          implicitWidth: root.backwidth
          implicitHeight: root.backheight
          x: root.leftPadding
          y: parent.height / 2 - height / 2
          radius: width/2
          color: root.checked ? root.backReccolorIsC : root.backReccolorNoC
          border.color: root.checked ? (root.down ? "#CCCCCC" : root.backReccolorIsC)
                            : (root.down ? root.backReccolorIsC : "#CCCCCC")

          Rectangle {
              id : smallRect
              width: height
              height: backrec.height
              radius: width/2
              color: root.down ? root.switchBtncolorIsC : root.switchBtncolorNoC
              border.color: root.checked ? (root.down ?  "#A0A0A0": root.switchBtnbordercolor)
                                : (root.down ? root.backReccolorIsC :"#A0A0A0")

              NumberAnimation on x{
                  to: root.backwidth-smallRect.width
                  running: root.checked ? true : false
                  duration: root.objduration
              }
              NumberAnimation on x{
                  to: 0
                  running: root.checked ? false : true
                  duration: root.objduration
              }
          }
      }
      contentItem: Text {
          text: root.checked ? root.checkedtext : root.text
          font.pixelSize:root.fontsize
          font.bold: root.fontbold
          color: root.down ? root.fontcolorIsC : root.fontcolorNoC
          verticalAlignment: Text.AlignVCenter
          anchors.left: indicator.right
          anchors.leftMargin: 4
      }
}
