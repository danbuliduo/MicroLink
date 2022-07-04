#include "microlinkthread.h"
#include <QDebug>
MicroLinkThread::MicroLinkThread(QObject *parent) : QObject{parent}
{

}
void MicroLinkThread::Runcode(QString parameter)
{
    emit callresultReady(parameter);
}
