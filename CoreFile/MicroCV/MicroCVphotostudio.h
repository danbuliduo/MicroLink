#ifndef MICROCVPHOTOSTUDIO_H
#define MICROCVPHOTOSTUDIO_H

#include <QObject>
#include <QImage>
#include <QThread>
#include "./CoreFile/PublicClass/microlinkthread.h"

class MicroCvPhotoStudio : public QObject
{
    Q_OBJECT
public:
    explicit MicroCvPhotoStudio(QObject *parent = nullptr);
    ~MicroCvPhotoStudio();
    Q_INVOKABLE void setQrCode(QString data);
    Q_INVOKABLE void getPath(QString path);
private:
    QThread microThread;
signals:
    void startThread(QString path);
    void callQmlRefeshImg();
public slots:
    void imgGREY(QString path);
    void DeleteThread();
};

#endif // MICROCVPHOTOSTUDIO_H
