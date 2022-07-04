CONFIG += c++11
INCLUDEPATH += $$PWD

HEADERS += \
    $$PWD/statusbar.h

SOURCES += \
    $$PWD/statusbar.cpp

android {
    QT += core-private
    HEADERS += \
       $$PWD/statusbar_p.h
    SOURCES += \
        $$PWD/statusbar_android.cpp\

} else:ios {
    LIBS += -framework UIKit

    OBJECTIVE_SOURCES += \
        $$PWD/statusbar_ios.mm
} else {
    SOURCES += \
        $$PWD/statusbar_dummy.cpp
}
