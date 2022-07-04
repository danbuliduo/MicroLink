#-------------------------------------------------
#
# Project created by QtCreator 2022-02-12
#
#-------------------------------------------------
QT += core quick gui                    #Base
QT += sql                                     #数据库
QT += sensors positioning            #传感器
QT += multimedia                        #媒体
QT += charts                                #图表
QT += websockets webview         #WEB
QT += bluetooth                          #蓝牙
QT += core-private
android
{
    HEADERS += CoreFile/AppInit.h

    SOURCES += CoreFile/AppInit.cpp \
                          ApplicationEngine.cpp

    RESOURCES += qml.qrc\
                             res.qrc\
                             VL.Control/vlcontrol.qrc

    include($$PWD/CoreFile/MicroLink.pri)
    include($$PWD/OpenLib/android_opencv_4_5_4/opencv.pri)
    include($$PWD/OpenLib/android_openssl/openssl.pri)

    DISTFILES += Android/AndroidManifest.xml \
                         Android/build.gradle \
                         Android/gradle.properties \
                         Android/gradle/wrapper/gradle-wrapper.jar \
                         Android/gradle/wrapper/gradle-wrapper.properties \
                         Android/gradlew \
                         Android/gradlew.bat \
    Android/libs/open_sdk_3.5.12.2_r97423a8_lite.jar \
                          Android/res/layout/activity_main.xml \
                         Android/res/values/libs.xml \
    Android/res/values/style.xml \
                         Android/res/xml/shortcuts.xml \
    Android/res/xml/systempath.xml \
                         Android/src/io/vlian/microlink/AndroidNotifiCation.java \
                         Android/src/io/vlian/microlink/AndroidSystemInfo.java \
                         Android/src/io/vlian/microlink/MicroLinkSystemModel.java \
    Android/src/io/vlian/microlink/QAppCompatActivity.java \
    Android/src/io/vlian/microlink/QMainActivity.java \
    Android/src/io/vlian/microlink/QShareReceiveActivity.java

    ANDROID_PACKAGE_SOURCE_DIR=$$PWD/Android
}

QML_IMPORT_PATH += $$PWD/VL.Control
# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
