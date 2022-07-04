#ifndef ANDROIDSYSTEMINFO_H
#define ANDROIDSYSTEMINFO_H

#include <QObject>
#include <QQmlEngine>
#include <QJniObject>

class AndroidSystemInfo : public QObject
{
    Q_OBJECT
public:
    explicit AndroidSystemInfo(QObject *parent = nullptr);
    Q_INVOKABLE static QString getAndroid_os_Build(QString value);
    Q_INVOKABLE QString getCurrentPath();
    Q_INVOKABLE QString getAndroidPath();

    Q_INVOKABLE void installAPK(QString path);
    static void fromJavaOne(JNIEnv *env,jobject thiz, jint x){
            Q_UNUSED(env);
            Q_UNUSED(thiz);
            qDebug() << x << "< 100";
    }
};
static QObject *androidsysteminfo_qobject_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine){
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    AndroidSystemInfo *androidsysteminfo = new AndroidSystemInfo;
    return  androidsysteminfo;
}
#endif // ANDROIDSYSTEMINFO_H
