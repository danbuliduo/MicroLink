#ifndef NOTIFICATION_H
#define NOTIFICATION_H

#include <QObject>
#include <QQmlEngine>

//![Notification 类]
class AndroidNotifiCation : public QObject
{
    Q_OBJECT
public:
    explicit AndroidNotifiCation(QObject *parent = nullptr);

    Q_INVOKABLE void setNotification(const QString &notification);
    QString notification() const;
signals:
     void notificationChanged();
private slots:
    void updateAndroidNotification();
private:
    QString m_notification;
};
//![Notification 类]
static QObject *androidnotification_qobject_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine){
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    AndroidNotifiCation *androidnotification=new AndroidNotifiCation;
    return  androidnotification;
}
#endif // NOTIFICATION_H
