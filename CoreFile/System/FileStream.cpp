#include "FileStream.h"
#include "./CoreFile/PublicClass/microtransition.h"
#include <QDir>
#include <QFile>
#include <QDateTime>
#include <QByteArray>
#include <QJniObject>
#include <QCoreApplication>

FileStream::FileStream(QObject *parent)  : QObject{parent}
{

}
bool FileStream::buildPath(QString path){
    QDir temp;
    if(temp.exists(path)){
        return false;
    }else{
         bool ok=temp.mkpath(path);
         return ok;
    }
}
bool FileStream::buildFolder(QString path){
    QDir temp;
    if(temp.exists(path)){
        return false;
    }else{
         bool ok=temp.mkdir(path);
         return ok;
    }
}
bool FileStream::buildFile(QString path){
    QFile file(path);
    if(file.open(QIODevice::ReadWrite | QIODevice::Text)){
        file.close();
        return true;
    }
    file.close();
    return false;
}
bool FileStream::deleteFile(QString path){
    if(path.isEmpty()||!QDir().exists(path)){
        return false;
    }
    QFileInfo fileInfo(path);
    if(fileInfo.isFile()){
        QFile::remove(path);
    }else if(fileInfo.isDir()){
        QDir dir(path);
        dir.removeRecursively();
    }
    return true;
}
bool FileStream::writeFile(QString path, QString text,int value){
    QFile file(path);

    QByteArray bar = QString::fromUtf8(text.toUtf8()).toLocal8Bit().data();
    bool isWrite=true;
    switch (value) {
    case 0:{
        if(file.open(QIODevice::WriteOnly | QIODevice::Text)){
            file.write(bar);
        }else{isWrite=false;}
    }break;
    case 1:{
        if(file.open(QIODevice::Append | QIODevice::Text)){
            file.write(bar);
        }else{isWrite=false;}
    }break;
    case 2:{
        if(file.open(QIODevice::Truncate | QIODevice::Text)){
            file.write(bar);
        }else{isWrite=false;}
    }break;
    default:isWrite=false;
    }
    file.close();
    return isWrite;
}
QString FileStream::readFile(QString path, int value){
    QFile file(path);
    QString text;
    switch (value) {
    case 0:{
        if(file.open(QIODevice::ReadOnly|QIODevice::Text)){
            text=file.readAll();
        }
    }break;
    }
    file.close();
    return text;//QString::fromUtf8(text.toUtf8()).toLocal8Bit().data();
}
QString FileStream::getPath(){
    return QDir::currentPath();
}
void FileStream::setPath(QString path){
    Path=path;
}
bool  FileStream::isExistSpecificFile(QString path){
    return QFile::exists(path);
}

QString FileStream::getFileSize(QString path){
    QFileInfo info(path);
    MicroTransition  microtransition;
    return microtransition.TFileSize(info.size(),2);
}

QString FileStream::getFileName(QString path){
    QFileInfo info(path);
    QJniObject javaNotification = QJniObject::fromString(path);
    QJniObject infos =QJniObject::callStaticObjectMethod(
                    "io/vlian/microlink/MicroLinkSystemModel",
                    "getFileType",
                    "(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;",
                    QNativeInterface::QAndroidApplication::context(),
                    javaNotification.object<jstring>());
    QString filename = QString::number(QDateTime::currentDateTime().toMSecsSinceEpoch(), 36);
    return filename+"."+infos.toString();

}

QString FileStream::getFileSuffix(QString path){
    QFileInfo info(path);
    return info.suffix();
}
