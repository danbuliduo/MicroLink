import QtQuick
import QtQuick.Controls
import sys.android.notification
import lps.websocket
import lps.tcp
import lps.bluetooth

import "qrc:/QmlFile/MicroControl/MicroChatListView/"
import "qrc:/QmlFile/QuickControl/"
import "qrc:/QmlFile/AppSettings/"

Page {
     background: Rectangle{
          color:"#F8F8FF"
     }
     BlueToothCentral{
         id:bt
         onCallAddNewDevice: function(address,name){
             _text.text+="ADDR:["+address+"]  Name:["+name+"]\n"
             console.log(address,name)
         }
         onCallScanDeviceFinished: {
             console.log("ScanDeviceFinished")
         }
         onCallScanServiceFinished: {
             console.log("ScanServiceFinished")
         }
         onCallDeviceConnectSucceed: {
             AndroidNotifiCation.setNotification("蓝牙链接成功")
         }
         onCallDeviceConnectError: function(error){
             console.log(error)
             AndroidNotifiCation.setNotification("蓝牙链接失败")
         }
         onCallDeviceDisconnect: {
             AndroidNotifiCation.setNotification("蓝牙失联")
         }
         onCallAddNewService: function(uuid,name){
              ts.text+="UUID:"+uuid+"Name:"+name+"\n"
         }
         onCallAddNewCharacteristic: function(uuid,name){
             console.log(uuid,name)
         }
     }

     WebSocketClient{
         id:websocket
         onCallTextMesageSink: function(message){
             console.log(message)
         }
     }
    TcpClient{
        id:tcpclient
        onCallMessageSink:function(message){
            console.log(message)
        }
        onCallDisConnect: {
            console.log("%%%%")
        }
    }
   Column{
       Row{
           TextField{
               id:t1
               width: 200
               height: 40
               text: "ws://127.0.0.1:12345"
           }
           Button{
               width: 50
               onClicked: {
                   websocket.newLink(t1.text)
               }
           }
           Button{
               width: 50
               onClicked: {
                   websocket.disLink()
               }
           }
           Button{
               width: 50
               onClicked: {
                   websocket.sendTextMessage("1258Web")
               }
           }
       }
       Row{
           TextField{
               id:t21
               width: 100
               height: 40
               text: "127.0.0.1"
           }
           TextField{
               id:t22
               width: 100
               height: 40
               text: "5800"
           }
           Button{
               width: 50
               onClicked: {
                   tcpclient.newLink(t21.text,Number(t22.text))
               }
           }
           Button{
               width: 50
               onClicked: {
                   tcpclient.disLink()
               }
           }
           Button{
               width: 50
               onClicked: {
                   tcpclient.sendTextMessage("sfsf")
               }
           }
       }
       Row{
           Button{
               text: "扫描"
               onClicked: {
                   _text.text=""
                  bt.startScanDevice()
               }
           }
           TextField{
               id:t31
               width: 150
               height: 40
               text: "FF:FF:10:55:49:87"
           }
           Button{
               text: "连接"
               onClicked: {
                   bt.connectToDevice(t31.text,bt.PublicAddress)
               }
           }
           Button{
               text: "断开"
               onClicked: {
                   bt.disconnectFromDevice(t31.text)
               }
           }
       }
       Row{
           Button{
               text: "服务"
               onClicked: {
                   ts.text=""
                   bt.startScanService(t31.text)
               }
           }
           TextField{
               id:t32
               text:"{00001802-0000-1000-8000-00805f9b34fb}"
           }
           TextField{
               id:t33
               text: "{00002a06-0000-1000-8000-00805f9b34fb}"
           }
       }
       Row{
           Button{
               onClicked: {
                   bt.connectToService(t31.text,t32.text)
               }
           }
           Button{
               text:"开始"
               onClicked: {
                   bt.writeCharacteristic(t31.text,t32.text,t33.text,"0100")
               }
           }
           Button{
               text: "关闭"
               onClicked: {
                   bt.writeCharacteristic(t31.text,t32.text,t33.text,"0000")
               }
           }
       }
   }
     Text{
         id:_text
        anchors.centerIn: parent
     }
     Text{
         id:ts
         anchors.bottom: parent.bottom
     }

    // MicroChatListViewCore{}



}
