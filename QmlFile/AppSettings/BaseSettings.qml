pragma Singleton
import QtQuick
import Qt.labs.settings
import "qrc:/QmlFile/AppSettings/ThemeFamily/"
import sys.android.system
Settings{
//--系统文件参数--
      readonly property string version : Qt.application.version
      readonly property string currentPath: AndroidSystemInfo.getCurrentPath()
      readonly property string androidPath: AndroidSystemInfo.getAndroidPath()
//--系统屏幕参数--
      readonly property double screenwidth: Screen.desktopAvailableWidth
      readonly property double screenheight: Screen.desktopAvailableHeight
//--系统功能启用--
      property bool openSoundeffect: true
//--系统主题色系--
      readonly property color qt_darkblue: "#080A16"

      property int themeID : 0

      property color accentcolor: QtTheme.accentcolor
      property color primarycolor
      property color backgroundcolor
      property color foregroundcolor
     //主题色系
      property color colorScheme_I: QtTheme.colorScheme_I
      property color colorScheme_II: QtTheme.colorScheme_II
      property color colorScheme_III: QtTheme.colorScheme_III
      property color colorScheme_IV: QtTheme.colorScheme_IV
      property color colorScheme_V: QtTheme.colorScheme_V
      property color colorScheme_VI: QtTheme.colorScheme_VI
      property color colorScheme_VII: QtTheme.colorScheme_VII
      property color colorScheme_VIII: QtTheme.colorScheme_VIII
      enum ThemeFamily{
         QtTheme,
         CyanTheme,
         RedTheme
      }
//--系统函数操作--
      function changeTheme(themeid){
          var themeobj =QtTheme
          switch(themeid){
              case BaseSettings.QtTheme: themeobj =QtTheme; break
              case BaseSettings.CyanTheme: themeobj =CyanTheme; break
              case BaseSettings.RedTheme: themeobj =RedTheme; break
          }
          themeID=themeid
          accentcolor =themeobj.accentcolor
          colorScheme_I=themeobj.colorScheme_I
          colorScheme_II=themeobj.colorScheme_II
          colorScheme_III=themeobj.colorScheme_III
          colorScheme_IV=themeobj.colorScheme_IV
          colorScheme_V=themeobj.colorScheme_V
          colorScheme_VI=themeobj.colorScheme_VI
          colorScheme_VII=themeobj.colorScheme_VII
          colorScheme_VIII=themeobj.colorScheme_VIII
      }
}


