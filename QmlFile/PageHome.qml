import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "qrc:/QmlFile/AppSettings/"
import "qrc:/QmlFile/QuickControl/"
import VQuickControls
import sys.sensor 1.0
import QtQuick.Dialogs
import QtQuick.Controls.Material
Page {
   id:root
   background: Rectangle{
       color:"#F8F8FF"
   }
   Text{
      text: "测试页面"
      anchors.centerIn: parent
   }
    Column{
        spacing: 8
        QcButton{
            width: 100
            height: 40
            text: "检查更新"
            onClicked: {
                dialog_AppUpdate.open()
            }
        }
        QcSwitch{
            backheight: 20
            backwidth: 40
           fontsize: 10
           text: "开启系统音效"
           checkedtext:"关闭系统音效"
        }
        QcDiskButton{

        }
        QcComboBox{
            textRole: "key"
            width:120
            currentIndex:BaseSettings.themeID
            model: ListModel {
                id:thememodel
                ListElement { key: "QtTheme"; value: 0 }
                ListElement { key: "CyanTheme"; value: 1 }
                ListElement { key: "RedTheme"; value: 2 }
            }
            onCurrentIndexChanged: {
                 BaseSettings.changeTheme(thememodel.get(currentIndex).value)
            }
        }
        /*
        Row{
        CheckBox{
            text: "复选框1"
        }
        CheckBox{
            text: "复选框2"

        }
        }
        Row{
            RadioButton{
                 text: "单选框1"
                 padding: 0
                 Material.accent: Material.Teal
                 font.pixelSize: 12
            }
            RadioButton{
                verticalPadding: 0
                horizontalPadding: 0
                 text: "单选框2"
            }
        }*/
        QcIconCornerMark{
             color: BaseSettings.accentcolor
        }
        QcBusyIndicator{

        }
    }
    Column{
        anchors.right: parent.right
        Button{
            width: 50
            text: "mesg"
            onClicked: {
                vt.open()
                //msgd.open()
            }
        }

        QcTextURL{
            text: "tyryr"
        }
        QcSlider{

        }
        QcTextField{
              width: 256
        }
        QcTextArea{
            width: 256
        }

    }
    QcMsgDialog{
        id:msgd
        width: 200
        tiptext: "TCP客户端与服务端不允许在此处同时使用\n请先关闭TCP服务端!"
    }
    VTitleMessageDialog{
        id:vt
       // buttonModel: VTitleMessageDialog.RefButton
        //messagetext: "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF$$$$$dd####################################################gdgdgdgddddddddddddddddddddddddddddd"
    }
    MobileSensor{
        id: mobilesensor
        onCallPositionUpdated: {
            console.log("ok")
        }
    }
}
