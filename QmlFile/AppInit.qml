import QtQuick
import QtQuick.Controls

import "qrc:/QmlFile/CoreControl/"
import "qrc:/QmlFile/AppSettings/"

import sys.info 1.0
import sys.filestream 1.0
import sys.android.system 1.0
import StatusBar
ApplicationWindow{
    id:initApp
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    color: BaseSettings.qt_darkblue
    property var componentObj : component_InitInterface.createObject(initApp)
    Component.onCompleted: {
        console.log(AndroidSystemInfo.getAndroid_os_Build("CPU_ABI"))
        var iplist=MicroLinkDefine.getIPv4()
        for(var i=0;i<iplist.length;i++){
            console.log(iplist[i])
        }
        iplist=MicroLinkDefine.getIPv6()
        for(i=0;i<iplist.length;i++){
            console.log(iplist[i])
        }

    }
    Component{
        id:component_InitInterface
        AppInitInterface{}
    }
    Component{
        id:component_MicroLink
        MicroLink{}
    }
    Loader{
        id:appCore_loader
        visible: status === Loader.Ready
    }
    Timer{
        id:timer
        interval: 3600
        running: true
        onTriggered: {
            componentObj.destroy()
             appCore_loader.sourceComponent=component_MicroLink
             initApp.visible=false
            initApp.flags=Qt.WindowStaysOnBottomHint
        }
    }
}

