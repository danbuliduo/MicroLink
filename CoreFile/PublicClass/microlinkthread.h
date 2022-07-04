#ifndef MICROLINKTHREAD_H
#define MICROLINKTHREAD_H

#include <QObject>
class MicroLinkThread : public QObject
{
    Q_OBJECT
public:
    explicit MicroLinkThread(QObject *parent = nullptr);
signals:
    void callresultReady(QString result);
public slots:
    void Runcode(QString parameter);
};

#endif // MICROLINKTHREAD_H
