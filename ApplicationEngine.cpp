#include <QApplication>
#include <QFontDatabase>
#include <QQmlApplicationEngine>

#include "CoreFile/AppInit.h"
#include "CoreFile/PublicClass/microimageprovider.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setOrganizationDomain(QStringLiteral("www.vlian.io"));
    app.setOrganizationName(QStringLiteral("HUBEI MINZU UNIVERSITY"));
    app.setApplicationName(QStringLiteral("WeLink"));
    app.setApplicationVersion(QStringLiteral("1.0.0"));

    AppInit appini;

    int fontid = QFontDatabase::addApplicationFont(QStringLiteral(":/Resources/Fonts/DroidSansFallback.ttf"));
    if(fontid != -1){
        QStringList basefont = QFontDatabase::applicationFontFamilies(fontid);
        if(basefont.size() != 0){
            QFont font(basefont.at(0));
            app.setFont(font);
        }
    }

    QQmlApplicationEngine engine;

    engine.addImportPath(QStringLiteral("qrc:/"));
    engine.addImageProvider(QStringLiteral("microImageProvider"),new MicroImageProvider);

    const QUrl url(QStringLiteral("qrc:/QmlFile/AppInit.qml"));

    QObject::connect(&engine,&QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl){
            if (!obj && url == objUrl) {QCoreApplication::exit(-1);}
        },Qt::QueuedConnection);

    engine.load(url);
    return app.exec();
}
