#include "TcpClient.h"

TcpClient::TcpClient(QObject *parent) : QObject{parent}
{
   Socket = new QTcpSocket(this);
}
TcpClient::~TcpClient(){
    Socket->close();
    Socket->deleteLater();
}
bool TcpClient::newLink(QString ip, quint16 port){
    Socket->deleteLater();
    Socket = new QTcpSocket(this);
    Socket->connectToHost(ip, port,QTcpSocket::ReadWrite);
    if(Socket->waitForConnected(100)){
        connect(Socket, &QTcpSocket::readyRead, this, &TcpClient::MessageSink);
        connect(Socket, &QTcpSocket::disconnected, this ,&TcpClient::DisConnect);
        return true;
    }
    return  false;
}
bool TcpClient::disLink(){
    if(Socket->isOpen()){
        Socket->disconnectFromHost();
        Socket->close();
        return true;
    }
    return false;
}
bool TcpClient::sendTextMessage(QString message){
    return Socket->write(message.toLocal8Bit().data(),strlen(message.toLocal8Bit().data())) ? true : false;
}
void TcpClient::MessageSink(){
    QString message=Socket->readAll();
    emit callMessageSink(QString::fromUtf8(message.toUtf8()).toLocal8Bit().data());
}
void TcpClient::DisConnect(){
    emit callDisConnect();
}
