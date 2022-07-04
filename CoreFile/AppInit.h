#ifndef APPINIT_H
#define APPINIT_H

#include <QObject>
//! APP初始化类
class AppInit : public QObject
{
    Q_OBJECT
public:
    explicit AppInit(QObject *parent = nullptr);
private:
    void QmlRegister();
    void BuildSystemFolder();
};

#endif // APPINIT_H
