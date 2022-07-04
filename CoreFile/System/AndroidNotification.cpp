#include "AndroidNotification.h"

#include <QJniObject>
#include <QCoreApplication>

AndroidNotifiCation::AndroidNotifiCation(QObject *parent) : QObject{parent}
{
    connect(this,&AndroidNotifiCation::notificationChanged,this,&AndroidNotifiCation::updateAndroidNotification);
}
void AndroidNotifiCation::setNotification(const QString &notification)
{
    if(m_notification==notification) return;
    m_notification = notification;
    emit notificationChanged();
}

QString AndroidNotifiCation::notification() const
{
    return m_notification;
}
void AndroidNotifiCation::updateAndroidNotification()
{
    QJniObject javaNotification = QJniObject::fromString(m_notification);
    QJniObject::callStaticMethod<void>(
                    "io/vlian/microlink/AndroidNotifiCation",
                    "notify",
                    "(Landroid/content/Context;Ljava/lang/String;)V",
                    QNativeInterface::QAndroidApplication::context(),
                    javaNotification.object<jstring>());
}
