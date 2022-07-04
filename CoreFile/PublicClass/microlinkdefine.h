#ifndef MICROLINKDEFINE_H
#define MICROLINKDEFINE_H

#include <QObject>
#include <QQmlEngine>

#define CURRENT_PATH "/data/data/io.vlian.microlink/files"
#define ANDROID_PATH "/storage/emulated/0/Android/io.vlian.microlink/files"

class MicroLinkDefine : public QObject
{
    Q_OBJECT
public:
    explicit MicroLinkDefine(QObject *parent = nullptr);
    Q_INVOKABLE QVariantList getIPv4();
    Q_INVOKABLE QVariantList getIPv6();
signals:

};
static QObject *microlinkdefine_qobject_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine){
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    MicroLinkDefine *microlinkdefine=new MicroLinkDefine;
    return  microlinkdefine;
}

#endif // MICROLINKDEFINE_H
