#include "microlinkdefine.h"
#include <QHostAddress>
#include <QNetworkInterface>
MicroLinkDefine::MicroLinkDefine(QObject *parent) : QObject{parent}
{

}

QVariantList MicroLinkDefine::getIPv4(){
    QVariantList IPList;
    foreach (QHostAddress addr,QNetworkInterface::allAddresses()){
        if(addr.protocol()==QAbstractSocket::IPv4Protocol&&addr.toString()!="127.0.0.1"){
            IPList.push_back(addr.toString());
        }
    }
   return IPList;
}

QVariantList MicroLinkDefine::getIPv6(){
    QVariantList IPList;
    foreach (QHostAddress addr,QNetworkInterface::allAddresses()){
        if(addr.protocol()==QAbstractSocket::IPv6Protocol&&addr.toString()!="127.0.0.1"){
            IPList.push_back(addr.toString());
        }
    }
   return IPList;
}
