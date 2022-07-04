#include "AppInit.h"

#include <QQmlApplicationEngine>
#include<QSqlDatabase>
#include <QDir>

#include "PublicClass/microlinkdefine.h"

#include "System/FileStream.h"
#include "System/SystemInstall.h"
#include "System/MobileSensor.h"
#include "System/SQL/ItemListSQL.h"
#include "System/SQL/FriendListSQL.h"
#include "System/AndroidSystemInfo.h"
#include "System/AndroidNotification.h"


#include "Model/ChatListDefine.h"
#include "Model/ChatListModel.h"
#include "Model/LinkModel/LinkVideoFrame.h"

#include "LinkProtocolSuite/LinkZeroCHIP.h"
#include "LinkProtocolSuite/TCPSocket/TcpServer.h"
#include "LinkProtocolSuite/TCPSocket/TcpClient.h"
#include "LinkProtocolSuite/WebSocket/WebSocketClient.h"
#include "LinkProtocolSuite/BlueTooth/BlueToothCentral.h"

#include "MicroCV/MicroCVphotostudio.h"

#include "Debug/src/statusbar.h"
AppInit::AppInit(QObject *parent)  : QObject{parent}
{
     qDebug()<<"[Code for QT]-------INITSTART";
     qDebug()<<"SQLDRIVERS:"<< QSqlDatabase::drivers();
     BuildSystemFolder();
     QmlRegister();
}
void AppInit::BuildSystemFolder()
{
    QString Path=QDir::currentPath();
    FileStream m_filestream;
    m_filestream.buildPath(Path+"/cache");
    m_filestream.buildPath(Path+"/AppInfo/apk");
    m_filestream.buildPath(Path+"/SysInfo");
    m_filestream.buildPath(Path+"/USER");
    m_filestream.buildPath(Path+"/USER/root/DataBase");
    m_filestream.buildPath(Path+"/USER/root/Item/Local");

    qmlRegisterType<StatusBar>("StatusBar", 1, 0, "StatusBar");
}
void AppInit::QmlRegister()
{
    qmlRegisterSingletonType<MicroLinkDefine>("sys.info",1,0,"MicroLinkDefine",microlinkdefine_qobject_singletontype_provider);
    qmlRegisterSingletonType<AndroidSystemInfo>("sys.android.system",1,0,"AndroidSystemInfo",androidsysteminfo_qobject_singletontype_provider);
    qmlRegisterSingletonType<AndroidNotifiCation>("sys.android.notification",1,0,"AndroidNotifiCation",androidnotification_qobject_singletontype_provider);
    qmlRegisterType<ItemListSQL>("sys.sql",1,0,"ItemListSQL");
    qmlRegisterType<FriendListSQL>("sys.sql",1,0,"FriendListSQL");
    qmlRegisterSingletonType<FileStream>("sys.filestream",1,0,"FileStream",filestream_qobject_singletontype_provider);
    qmlRegisterType<MobileSensor>("sys.sensor",1,0,"MobileSensor");
    qmlRegisterType<SystemInstall>("sys.install",1,0,"SystemInstall");

    qmlRegisterType<ChatData>("model.chatmodel",1,0,"ChatData");
    qmlRegisterType<ChatListModel>("model.chatmodel",1,0,"ChatListModel");
    qmlRegisterType<LinkVideoFrame>("model.linkmodel",1,0,"LinkVideoFrame");

    qmlRegisterType<LinkZeroCHIP>("lps.link.chip",1,0,"LinkZeroCHIP");
    qmlRegisterType<TcpServer>("lps.tcp",1,0,"TcpServer");
    qmlRegisterType<TcpClient>("lps.tcp",1,0,"TcpClient");
    qmlRegisterType<WebSocketClient>("lps.websocket",1,0,"WebSocketClient");
    qmlRegisterType<BlueToothCentral>("lps.bluetooth",1,0,"BlueToothCentral");

    qmlRegisterType<MicroCvPhotoStudio>("mcv.photostudio",1,0,"MLPhotoStudio");
}
