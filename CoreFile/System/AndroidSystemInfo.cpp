#include "AndroidSystemInfo.h"
#include "../PublicClass/microlinkdefine.h"
#include <QCoreApplication>
#include <QtCore/private/qandroidextras_p.h>

AndroidSystemInfo::AndroidSystemInfo(QObject *parent) : QObject{parent}
{

}

QString AndroidSystemInfo::getCurrentPath(){
    return CURRENT_PATH;
}

QString AndroidSystemInfo::getAndroidPath(){
    return ANDROID_PATH;
}

QString AndroidSystemInfo::getAndroid_os_Build(QString value){
    QJniObject javaString = QJniObject::fromString(value);
    javaString.object<jobject>();
    QJniObject info=QJniObject::callStaticObjectMethod(
                "io/vlian/microlink/AndroidSystemInfo",
                "getAndroid_os_Build",
                "(Ljava/lang/String;)Ljava/lang/String;",
                javaString.object<jstring>());
    return info.toString();
}

void AndroidSystemInfo::installAPK(QString path){
       const JNINativeMethod methods[] ={{"callNativeOne", "(I)V", reinterpret_cast<void *>(fromJavaOne)}};
       QJniEnvironment env;
       env.registerNativeMethods("io/vlian/microlink/QShareReceiveActivity", methods, 1);
       QJniObject::callStaticMethod<void>("io/vlian/microlink/QShareReceiveActivity", "foo", "(I)V", 110);

        /*QJniObject jFilePath = QJniObject::fromString(path);
        QJniObject activity = QtAndroidPrivate::activity();
        QJniObject object=QJniObject("io/vlian/microlink/QMainActivity");
        object.callMethod<void>(
                    "startVibrator",
                    "(Landroid/content/Context;)V",
                    QNativeInterface::QAndroidApplication::context());
        object.callMethod<void>(
                    "shareFile",
                    "(Ljava/lang/String;Lorg/qtproject/qt/android/bindings/QtActivity;)V",
                    jFilePath.object<jstring>(),
                    activity.object<jobject>());*/
}
