#ifndef FILESTREAM_H
#define FILESTREAM_H

#include <QObject>
#include <QQmlEngine>
class FileStream : public QObject
{
    Q_OBJECT
public:
    explicit FileStream(QObject *parent = nullptr);
    Q_INVOKABLE bool buildPath(QString path);
    Q_INVOKABLE bool buildFolder(QString path);
    Q_INVOKABLE bool buildFile(QString path);
    Q_INVOKABLE bool deleteFile(QString path);
    Q_INVOKABLE bool writeFile(QString path,QString text,int value);
    Q_INVOKABLE QString readFile(QString path,int value);

    Q_INVOKABLE void setPath(QString path);
    Q_INVOKABLE QString getPath();

    Q_INVOKABLE bool isExistSpecificFile(QString path);
    Q_INVOKABLE QString getFileSize(QString path);
    Q_INVOKABLE QString getFileName(QString path);
    Q_INVOKABLE QString getFileSuffix(QString path);
private:
    QString Path;
};

static QObject *filestream_qobject_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine){
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    FileStream *filestream=new FileStream;
    return  filestream;
}
#endif // FILESTREAM_H
