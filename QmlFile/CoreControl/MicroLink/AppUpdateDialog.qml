import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import "qrc:/QmlFile/AppSettings/"
import "qrc:/QmlFile/QuickControl/"
import sys.install 1.0
import sys.android.system
Dialog{
    id:root
     width: isV ? rootAPP.width*0.75 :rootAPP.width*0.5
     height: isV ? rootAPP.height*0.4 :rootAPP.height*0.6
     x:(rootAPP.width-width)/2
     y:(rootAPP.height-height-rootAPP.footer.height-rootAPP.header.height)/2
     modal: false
     closePolicy: Popup.NoAutoClose
     enter: Transition {
         PropertyAnimation {
             duration: 500
             easing.type: Easing.OutBounce
             property: 'scale'
             from: 0
             to: 1
         }
     }
     exit: Transition {
         PropertyAnimation {
             duration: 500
             property: 'scale'
             from: 1
             to: 0
         }
     }
     Loader{
         anchors.fill: parent
         asynchronous: true
         visible: status == Loader.Ready
         sourceComponent: root.visible ? component_AppUpdata : undefined
     }
     Component{
         id:component_AppUpdata
         Item{
             anchors.fill: parent
             QcButton{
                 height: 38
                 anchors.left: parent.left
                 anchors.bottom: parent.bottom
                 anchors.bottomMargin: -8
                 text: "下载更新"
                 fontcolor: "#EEEEEE"
                 radius: 2
                 color: BaseSettings.accentcolor
                 onClicked: {
                     sysinstall.httpDownload()
                 }
              }
             QcButton{
                  height: 38
                  anchors.right: parent.right
                  anchors.bottom: parent.bottom
                  anchors.bottomMargin: -8
                  text: "放弃取消"
                  fontcolor: "#FFFFFF"
                  radius: 2
                  color: "#606060"
                  onClicked: {
                      root.close()
                  }
             }
             SystemInstall{
                  id:sysinstall
                  url:"https://www.bigiot.net/Public/upload/app/v2/www.bigiot.net.apk"
                  filename: "/storage/emulated/0/Download/WeLink/www.bigiot.net.apk"
                  onCallProgressPosition: function(bytesSent, bytesTotal){
                      progressbar.value=(bytesSent/bytesTotal)
                      cstext.text="大小："+bytesTotal+"比特\n当前："+bytesSent+"比特\n进度："+(progressbar.value*100).toFixed(2)+"%"
                  }
                  onCallDownloadFinished: {
                      console.log("DownloadFinished")
                  }
             }
             Button{
                 anchors.centerIn: parent
                 onClicked: {
                     AndroidSystemInfo.installAPK(sysinstall.filename)
                 }
             }
             Text{
                 text: "WeLink 🚀 Update"
                 font.pixelSize: 20
                 font.bold: true
                 color: BaseSettings.accentcolor
                 anchors.horizontalCenter: parent.horizontalCenter
             }
             QcProgressBar{
                 id:progressbar
                 anchors.top: parent.top
                 anchors.topMargin: 60
                 width: parent.width
                 backcolor: BaseSettings.colorScheme_I
                 contcolor:BaseSettings.colorScheme_VII
             }
             Text{
                 id:cstext
                 color: BaseSettings.accentcolor
                 font.pixelSize: 14
                 anchors.centerIn: parent
             }
         }
     }
}
