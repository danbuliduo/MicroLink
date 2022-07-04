#ifndef SYSTEMINSTALL_H
#define SYSTEMINSTALL_H

#include <QObject>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkAccessManager>
#include <QDateTime>
#include <QTime>
#include <QFile>

class SystemInstall : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString url READ getUrl WRITE setUrl)
    Q_PROPERTY(QString filename READ getFileName WRITE setFileName)

public:
    explicit SystemInstall(QObject *parent = nullptr);
    ~SystemInstall();
    void setFileName(QString filename);
    void setUrl(QString url);
    QString getUrl();
    QString getFileName();

signals:
    void callProgressPosition(double bytesSent, double bytesTotal);
    void callDownloadFinished();
protected slots:
    void httpDownload();
    void replyFinished(QNetworkReply*reply);
    void onDownloadProgress(qint64 bytesSent,qint64 bytesTotal);
    void onReadyRead();

private:
    QString URL;
    QString FileName;
    QFile *file;
    QNetworkAccessManager *accessManager;
    QNetworkRequest request;
    QNetworkReply *reply;
    QTime downloadTime;
};

#endif // SYSTEMINSTALL_H
