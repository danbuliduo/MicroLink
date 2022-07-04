#include "LinkZeroCHIP.h"
#include "./CoreFile/PublicClass/microimageprovider.h"
#include <QJsonDocument>
#include <QJsonParseError>
#include <QJsonObject>

LinkZeroCHIP::LinkZeroCHIP(QObject *parent, quint16 tcplinkport ,quint16 tcpimgport)  : QObject{parent}
{
      qDebug()<<"[LinkZeroCHIP] NWE";
      TcpLinkServer=new TcpServer(this, tcplinkport);
      connect(TcpLinkServer,&TcpServer::callMessageSink,this,&LinkZeroCHIP::JsonDataSink);
      connect(TcpLinkServer,&TcpServer::callNewConnect,this,&LinkZeroCHIP::callNewConnect);
      connect(TcpLinkServer,&TcpServer::callDisConnect,this,&LinkZeroCHIP::callDisConnect);

      TcpIMGServer=new QTcpServer(this);
      TcpIMGServer->listen(QHostAddress::Any,tcpimgport);
      connect(TcpIMGServer,&QTcpServer::newConnection,this,&LinkZeroCHIP::IMGConnect);
}
void LinkZeroCHIP::IMGConnect(){
    TcpIMGSocket = TcpIMGServer->nextPendingConnection();
    connect(TcpIMGSocket ,&QTcpSocket::readyRead ,this , &LinkZeroCHIP::IMGDataSink);
    emit callNewConnect(TcpIMGSocket->peerAddress().toString(),TcpIMGSocket->peerPort());
}
void LinkZeroCHIP::IMGDataSink(){
    QByteArray buffer;
    buffer=TcpIMGSocket->readAll();
    int start=buffer.indexOf("START");
    int end=buffer.lastIndexOf("END");
    qDebug()<<start<<end;
    if(start!=-1){
        if(start==0){
            if(end!=-1){
                BUFF=buffer.mid(start+5,end-5);
                QImage img;
                qDebug()<<img.loadFromData(BUFF,"jpg");
                MicroImageProvider::setImage(img);
                emit callIMGDataSink();
                BUFF.clear();
                qDebug()<<"STRAT AND END ALL OUT"<<start<<end<<buffer.size();
                return;
            }else{
                BUFF+=buffer.mid(start+5,buffer.length()-5);
                qDebug()<<"STRAT DATA"<<start<<end<<buffer.size();
            }
        }
        else{
            if(end!=-1){
                BUFF+=buffer.mid(0,end);
                QImage img;
                qDebug()<<img.loadFromData(BUFF,"jpg");
                MicroImageProvider::setImage(img);
                emit callIMGDataSink();
                BUFF=buffer.mid(start+5,buffer.size()-start-4);                                         //清空BUFF字节数组
                qDebug()<<"DATA END START DATA"<<start<<end<<buffer.size();
                return;
            }else{
            BUFF=buffer.mid(start+5,buffer.size()-start-4);
            qDebug()<<"STRAT AND END???"<<start<<end<<buffer.size();
            }
        }
    }else{
        if(end!=-1){
            BUFF+=buffer.mid(0,end);
            QImage img;
            qDebug()<<img.loadFromData(BUFF,"jpg");
            MicroImageProvider::setImage(img);
            emit callIMGDataSink();
            BUFF=buffer.mid(end+3,buffer.size());                                      //清空BUFF字节数组
            qDebug()<<"DATA END"<<start<<end<<buffer.size();
            return;
        }
        else if(buffer.size()!=0){
            BUFF+=buffer;
            qDebug()<<"DATA"<<start<<end<<buffer.size();
        }
    }
}

bool LinkZeroCHIP::setTcpLinkPort(quint16 port){
    return TcpLinkServer->initLink(port);
}
void LinkZeroCHIP::JsonDataSink(QString jsondata){
    QJsonParseError jsonParseError;
    QJsonDocument jsonDocument=QJsonDocument::fromJson(jsondata.toLocal8Bit().data(),&jsonParseError);
     if(jsonParseError.error !=QJsonParseError::NoError){
         qDebug()<< jsondata<<"ERROR:"<<jsonParseError.errorString();
         return;
     }
     if( jsonDocument.isObject()){
         QJsonObject jsonObject=jsonDocument.object();
         QString JsonData;
         for(QJsonObject::Iterator it=jsonObject.begin();it!=jsonObject.end();it++){
             switch (it->type()) {
             case QJsonValue::Object:
                 JsonData=QString(QJsonDocument(it.value().toObject()).toJson());
                 break;
             case QJsonValue::Array:
               //如果是Array继续递归解析
                 break;
             case QJsonValue::Bool:
                 break;
             case QJsonValue::Double:
                 break;
             case QJsonValue::String:
                 JsonData=it.value().toString();
                 break;
             case QJsonValue::Null: break;
             case QJsonValue::Undefined: break;
             default: break;
             }
             emit callJsonDataSink(it.key(),JsonData);
         }
     }else if(jsonDocument.isArray()){
         return;
     }else{
         return;
     }
}
void LinkZeroCHIP::sendTextMessage(QString message){
    TcpLinkServer->sendTextMessage(message);
}
void LinkZeroCHIP::sendTextMessage(QString message, QString ip){
    TcpLinkServer->sendTextMessage(message, ip);
}
void LinkZeroCHIP::sendTextMessage(QString message, QString ip, quint16 port){
    TcpLinkServer->sendTextMessage(message, ip, port);
}
