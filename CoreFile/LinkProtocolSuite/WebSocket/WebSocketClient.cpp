
#include "WebSocketClient.h"

WebSocketClient::WebSocketClient(QObject *parent) : QObject{parent}
{
    initLink();
}
WebSocketClient::~WebSocketClient(){
    Socket->close();
    Socket->deleteLater();
}
void WebSocketClient::initLink()
{
    Socket = new QWebSocket;
    Socket->setParent(this);
    connect(Socket,&QWebSocket::textMessageReceived,this,&WebSocketClient::TextMesageSink);
}
bool WebSocketClient::newLink(QString url){
    Socket->open(QUrl(url));
    return true;
}
void WebSocketClient::disLink(){
    Socket->close();
}
qint64 WebSocketClient::sendTextMessage(QString message){
    return Socket->sendTextMessage(message);
}
void WebSocketClient::TextMesageSink(QString message){
    emit callTextMesageSink(message);
}
