#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>

class TcpClient : public QObject
{
    Q_OBJECT
public:
    explicit TcpClient(QObject *parent = nullptr);
    ~TcpClient();
    Q_INVOKABLE bool sendTextMessage(QString message);
    Q_INVOKABLE bool newLink(QString ip, quint16 port);
    Q_INVOKABLE bool disLink();
signals:
    void callMessageSink(QString message);
    void callDisConnect();
public slots:
   void MessageSink();               //消息接收
   void DisConnect();                //断开连接槽
private:
   QTcpSocket *Socket;
};

#endif // TCPCLIENT_H
