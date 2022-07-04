#ifndef TCPSERVER_H
#define TCPSERVER_H

#include <QObject>
#include <QTcpSocket>
#include <QTcpServer>
class TcpServer : public QObject
{
    Q_OBJECT
public:
    explicit TcpServer(QObject *parent = nullptr,quint16 port=10000);
    //! [TcpServer初始化](端口)
    Q_INVOKABLE bool initLink(quint16 port);
    //! [Tcp广播](报文)
    Q_INVOKABLE void sendTextMessage(QString message);
    //! [Tcp组播](报文,IP地址)
    Q_INVOKABLE void sendTextMessage(QString message,QString ip);
     //! [Tcp单播](报文,IP地址,端口)
    Q_INVOKABLE void sendTextMessage(QString message,QString ip,quint16 port);
    //! [删除TcpSocket](ip,端口)
    Q_INVOKABLE void delSocket(QString ip,quint16 port);
    //! [获取TcpSocket列表]
    QList<QTcpSocket *> getSocketList();
signals:
    //! [消息更新信号](消息数据)
    void callMessageSink(QString message);
    //! [新的连接信号](ip,端口)
    void callNewConnect(QString ip,quint16 port);
    //! [端口断开信号](ip,端口)
    void callDisConnect(QString ip,quint16 port);
public slots:
    //! [消息接收公共插槽]
   void MessageSink();
   //! [建立连接公共插槽]
   void NewConnect();
   //! [断开连接公共插槽]
   void DisConnect();
private:
   //!QTcp服务器对象
   QTcpServer *Server;
   //!Tcp套接字列表
   QList<QTcpSocket *> TcpSocketList;
};

#endif // TCPSERVER_H
