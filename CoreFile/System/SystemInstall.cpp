#include "SystemInstall.h"

SystemInstall::SystemInstall(QObject *parent)  : QObject{parent}
{
    accessManager=nullptr;
    reply=nullptr;
}
SystemInstall::~SystemInstall()
{

}
QString SystemInstall::getUrl()
{
    return URL;
}
QString SystemInstall::getFileName(){
    return FileName;
}
void SystemInstall::setUrl(QString url){
     URL=url;
}
void SystemInstall::setFileName(QString filename){
    FileName=filename;
}
void SystemInstall::httpDownload(){
    file=new QFile(FileName);
    file->open(QIODevice::WriteOnly);//只读方式打开文件
    accessManager=new QNetworkAccessManager(this);
    request.setUrl(URL);
    reply=accessManager->get(request);//通过发送数据，返回值保存在reply指针里.
    connect(accessManager,&QNetworkAccessManager::finished,this,&SystemInstall::replyFinished);//finish为manager自带的信号，replyFinished是自定义的
    connect(reply,&QNetworkReply::downloadProgress,this,&SystemInstall::onDownloadProgress);//download文件时进度
    connect(reply,&QNetworkReply::readyRead,this,&SystemInstall::onReadyRead);
}
void SystemInstall::replyFinished(QNetworkReply *reply){
    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    qDebug()<<"HTTP-StatusCode:"<<status_code;
    if(reply->error() == QNetworkReply::NoError)
    {
      QByteArray bytes = reply->readAll();  //获取字节
      QString result(bytes);                         //转化为字符串
      qDebug()<<"resultbyt"<<result;
      file->flush();
      file->close();
      file->deleteLater();
      file=nullptr;
    }else{

    }
    reply->deleteLater();
    reply=nullptr;
    accessManager->deleteLater();
    accessManager=nullptr;
    emit callDownloadFinished();
}
void SystemInstall::onDownloadProgress(qint64 bytesSent, qint64 bytesTotal){
    emit callProgressPosition(bytesSent, bytesTotal);
}
void SystemInstall::onReadyRead(){
    file->write(reply->readAll());
}

