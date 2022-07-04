#ifndef MICROTRANSITION_H
#define MICROTRANSITION_H

#include <QObject>

class MicroTransition
{
public:
    explicit MicroTransition();
    QString TFileSize(const qint64 &size,const qint64 &acc);
signals:

};

#endif // MICROTRANSITION_H
