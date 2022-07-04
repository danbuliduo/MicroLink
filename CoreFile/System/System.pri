#---------------------------------------------------------------------------------------
#    By: 邓明(D.Ming)    Date: 2022-02-17
#    功能：安卓手机系统操作
#    QT+=sensors positioning  quick core gui
#---------------------------------------------------------------------------------------
HEADERS += \
    $$PWD/AndroidSystemInfo.h \
    $$PWD/AndroidNotification.h \
    $$PWD/FileStream.h\
    $$PWD/MobileSensor.h \
    $$PWD/SQL/FriendListSQL.h \
    $$PWD/SQL/ItemListSQL.h \
    $$PWD/SystemInstall.h

SOURCES += \
    $$PWD/AndroidSystemInfo.cpp \
    $$PWD/AndroidNotification.cpp \
    $$PWD/FileStream.cpp \
    $$PWD/MobileSensor.cpp \
    $$PWD/SQL/FriendListSQL.cpp \
    $$PWD/SQL/ItemListSQL.cpp \
    $$PWD/SystemInstall.cpp
