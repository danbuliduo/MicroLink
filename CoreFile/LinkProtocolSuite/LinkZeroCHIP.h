#ifndef LINKZEROCHIP_H
#define LINKZEROCHIP_H

#include "./TCPSocket/TcpServer.h"
#include <QObject>
#include <QHash>
typedef struct SocketNode{
    QString ip;
    quint16 port;
}SocketNode;
class LinkZeroCHIP : public QObject
{
    Q_OBJECT
    //Q_PROPERTY(quint16 tcpLinkPort READ getTcpLinkPort WRITE setTcpLinkPort)
public:
    explicit LinkZeroCHIP(QObject *parent = nullptr,
                                       quint16 tcplinkport = 52000,
                                       quint16 tcpimgport = 52001);
    Q_INVOKABLE bool setTcpLinkPort(quint16 port);
    Q_INVOKABLE void sendTextMessage(QString message);
    Q_INVOKABLE void sendTextMessage(QString message,QString ip);
    Q_INVOKABLE void sendTextMessage(QString message,QString ip,quint16 port);
signals:
    void callJsonDataSink(QString conname,QString jsonobj);
    void callIMGDataSink();
    void callNewConnect(QString ip,quint16 port);
    void callDisConnect(QString ip,quint16 port);
public slots:
    void JsonDataSink(QString jsondata);
    void IMGDataSink();
    void IMGConnect();
private:
    TcpServer *TcpLinkServer;
    QTcpServer *TcpIMGServer;
    QTcpSocket *TcpIMGSocket;
    QByteArray BUFF;
    QHash<SocketNode,int> LinkRootHash;
};

#endif // LINKZEROCHIP_H
