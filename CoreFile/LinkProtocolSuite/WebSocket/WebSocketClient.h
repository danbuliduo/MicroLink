#ifndef WEBSOCKETCLIENT_H
#define WEBSOCKETCLIENT_H

#include <QObject>
#include <QWebSocket>

class WebSocketClient : public QObject
{
    Q_OBJECT
public:
    explicit WebSocketClient(QObject *parent = nullptr);
    ~WebSocketClient();
    void initLink();
    Q_INVOKABLE bool newLink(QString url);
    Q_INVOKABLE void disLink();
    Q_INVOKABLE qint64 sendTextMessage(QString message);
signals:
   void callTextMesageSink(QString message);
public slots:
    void TextMesageSink(QString message);
private:
    QWebSocket *Socket;
};

#endif // WEBSOCKETCLIENT_H
