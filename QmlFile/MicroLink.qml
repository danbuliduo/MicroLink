import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects
import "qrc:/QmlFile/QuickControl/"
import "qrc:/QmlFile/CoreControl/"
import "qrc:/QmlFile/CoreControl/MicroLink/"
import "qrc:/QmlFile/AppSettings/"
import "qrc:/vlian.js" as VLJS
import StatusBar
ApplicationWindow{
    id:rootAPP
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    color: BaseSettings.accentcolor
    header: toolbar
    footer:tabbar
    property bool isV: height >width
    onIsVChanged: {
        !isV ? status.setFlag(StatusBar.SET_FULLSCREEN) : status.setFlag(StatusBar.NOT_FULLSCREEN)
    }
    Component.onCompleted: {
           console.log("MicroLink=====Component.onCompleted=====")
           console.log(VLJS.str2time('2015-03-05 17:59:00.0'))
    }

    ListModel {
         id: tablistmodel
         ListElement {
             btntitle: "主页";
             imgurl: "qrc:/Resources/Images/icon/icons8_home_page_64px_2.png"
         }
         ListElement {
             btntitle: "工具沙盒";
             imgurl: "qrc:/Resources/Images/icon/icons8_smartphone_ram_64px.png"
         }
         ListElement {
             btntitle: "LinkCube";
             imgurl: "qrc:/Resources/Images/icon/icons8_module_64px_1.png"
         }
         ListElement {
             btntitle: "我"
             imgurl: "qrc:/Resources/Images/icon/icons8_customer_64px_1.png"
         }
         ListElement {
             btntitle: "设置"
             imgurl: "qrc:/Resources/Images/icon/icons8_settings_52px.png"
         }
    }

    ToolBar{
        id:toolbar
        contentHeight: toolbutton.implicitHeight
        background: Rectangle{
           color: BaseSettings.accentcolor
        }
        ToolButton{
            id:toolbutton
            Image{
                width: height
                height: toolbutton.height/2
                anchors.centerIn: parent
                source: "qrc:/Resources/Images/icon/icons8_menu_48px.png"
            }
            onClicked: {
                drawer_SideBar.open()
            }
        }

        Label{
            text: tablistmodel.get(tabbar.currentIndex).btntitle
            width: 80
            color: "white"
            font.pixelSize: 18
            font.bold: true
            anchors.left: toolbutton.right
            anchors.verticalCenter: parent.verticalCenter
        }

        ToolButton{
            anchors.right: parent.right
            anchors.rightMargin: 2
            Image{
                width: height
                height:toolbutton.height/2
                source: "qrc:/Resources/Images/icon/icons8_plus_math_48px.png"
                anchors.centerIn: parent
            }
            onClicked: {
               popup_ToolCard.show()
            }
        }
    }
    StatusBar {
        id:status
        color: BaseSettings.accentcolor
       // flag: isV ? StatusBar.SET_FULLSCREEN : StatusBar.NOT_FULLSCREEN
    }
    SwipeView{
        id:swipview
        anchors.fill: parent
        currentIndex: tabbar.currentIndex
        interactive: false
        PageHome{
             id:page_home
        }
        PageToolKit{
            id:page_box
            Loader{
                anchors.fill: parent
                sourceComponent: swipview.currentIndex===1 ?component_ToolKitCore  : undefined
            }
            Component{
                 id:component_ToolKitCore
                 ToolKitCore{
                     id:toolkitcore
                 }
            }
        }
        PageLinkCube{
             id:page_LinkCube
             Loader{
                 anchors.fill: parent
                 sourceComponent: swipview.currentIndex===2 ?component_LinkCubeCore : undefined
             }
             Component{
                  id:component_LinkCubeCore
                  LinkCubeCore{
                      id:linkcubecore
                  }
             }
        }
        PageUser{
            id:page_User
            Loader{
                anchors.fill: parent
                sourceComponent: swipview.currentIndex===3 ?component_UserCore : undefined
            }
            Component{
                 id:component_UserCore
                 UserCore{
                     id:usercore
                 }
            }
        }
        PageSetting{
           id:page_Setting
           Loader{
               anchors.fill: parent
               sourceComponent: swipview.currentIndex===4 ?component_SettingCore : undefined
           }
           Component{
                id:component_SettingCore
                SettingCore{
                    id:settingcore
                }
           }
        }
    }

    TabBar {
        id: tabbar
        height: 54
        currentIndex: swipview.currentIndex
        Material.accent: BaseSettings.accentcolor
        background: Rectangle{
            color: "#FFFFFF"
        }
        Repeater {
             model: tablistmodel
             TabButton {
                 height: tabbar.height*0.8
                 contentItem:Text{
                     text: btntitle
                     horizontalAlignment: Text.AlignHCenter
                     anchors.bottom: parent.bottom
                     anchors.bottomMargin: -1
                     color: (model.index === tabbar.currentIndex) ? BaseSettings.accentcolor : "#606060"
                 }
                 background:Image{
                     width: 24
                     height: 24
                     anchors.horizontalCenter: parent.horizontalCenter
                     source:imgurl
                     ColorOverlay{
                         anchors.fill: parent
                         source: parent
                         color: model.index === tabbar.currentIndex ? BaseSettings.accentcolor : "#606060"
                     }
                 }
             }
        }
    }

    AppUpdateDialog{
        id:dialog_AppUpdate
    }

    ToolCardPopup{
        id:popup_ToolCard
    }
    SideBarDrawer{
        id:drawer_SideBar
    }
    FontLoader {
      source: "qrc:/Resources/Fonts/AgencyFB.ttf"
    }
}
