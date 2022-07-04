#include "TcpServer.h"

TcpServer::TcpServer(QObject *parent,quint16 port) : QObject{parent}
{
    initLink(port);
}
bool TcpServer::initLink(quint16 port){
    Server =new QTcpServer(this);
    if(!Server->listen(QHostAddress::Any,port)){
        qDebug()<<"[TcpServer ERROR:]"<<Server->errorString();
        return false;
    }else{
        QObject::connect(Server,&QTcpServer::newConnection,this,&TcpServer::NewConnect);
        return true;
    }
}

void TcpServer::NewConnect(){
    QTcpSocket *TcpSocket = Server->nextPendingConnection();
    qDebug()<<TcpSocket->peerAddress().toString();
    TcpSocketList.append(TcpSocket);
    QObject::connect(TcpSocket,&QTcpSocket::readyRead ,this , &TcpServer::MessageSink);
    QObject::connect(TcpSocket,&QTcpSocket::disconnected, this ,&TcpServer::DisConnect);
    emit callNewConnect(TcpSocket->peerAddress().toString(),TcpSocket->peerPort());
}
void TcpServer::DisConnect(){
    int i=-1;
    foreach(QTcpSocket *socket,TcpSocketList){
        i++;
        if(socket->state()==QTcpSocket::UnconnectedState){
            qDebug()<<socket->peerAddress().toString()<<"closed"<<i;
            qDebug()<<socket->peerPort()<<socket->peerName();
            socket->deleteLater();
            TcpSocketList.removeAt(i);
            emit callDisConnect(socket->peerAddress().toString(),socket->peerPort());
        }
    }
}
void TcpServer::MessageSink(){
    foreach(QTcpSocket *socket, TcpSocketList){
        if(socket->bytesAvailable()>0){
            QString message=socket->readAll();
            emit callMessageSink(QString::fromUtf8(message.toUtf8()).toLocal8Bit().data());
        }
    }
}
void TcpServer::sendTextMessage(QString message){
    foreach(QTcpSocket *socket, TcpSocketList){
         socket->write(message.toLocal8Bit().data(),strlen(message.toLocal8Bit().data()));
    }
}
void TcpServer::sendTextMessage(QString message,QString ip){
    foreach(QTcpSocket *socket, TcpSocketList){
        if(socket->peerAddress().toString()==ip){
            socket->write(message.toLocal8Bit().data(),strlen(message.toLocal8Bit().data()));
        }
    }
}
void TcpServer::sendTextMessage(QString message,QString ip ,quint16 port){
    foreach(QTcpSocket *socket, TcpSocketList){
         if(socket->peerAddress().toString()==ip&&socket->peerPort()==port){
              socket->write(message.toLocal8Bit().data(),strlen(message.toLocal8Bit().data()));
              return;
         }
    }
}
void  TcpServer::delSocket(QString ip,quint16 port){
    int i=-1;
    foreach(QTcpSocket *socket,TcpSocketList){
        i++;
        if(socket->peerAddress().toString()==ip&&socket->peerPort()==port){
            qDebug()<<socket->peerAddress().toString()<<"closed"<<i;
            qDebug()<<socket->peerPort();
            socket->deleteLater();
            TcpSocketList.removeAt(i);
            emit callDisConnect(socket->peerAddress().toString(),socket->peerPort());
        }
    }
}
QList<QTcpSocket *> TcpServer::getSocketList(){
    return  TcpSocketList;
}
