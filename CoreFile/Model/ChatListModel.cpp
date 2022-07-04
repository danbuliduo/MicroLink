#include "ChatListModel.h"

#include <QDateTime>
#include <QRandomGenerator>
ChatListModel::ChatListModel(QObject *parent): QAbstractListModel(parent)
{

}
int ChatListModel::rowCount(const QModelIndex &parent) const
{
    if(parent.isValid()) return 0;
    return chatList.count();
}
QVariant ChatListModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) return QVariant();

    const int row=index.row();
    auto item=chatList.at(row);
    switch (role) {
        default: break;
        case Qt::UserRole+0:
            return item->isUser;
        case Qt::UserRole+1:
            return item->userID;
        case Qt::UserRole+2:
            return item->userName;
        case Qt::UserRole+3:
            return item->senderID;
        case Qt::UserRole+4:
            return item->senderName;
        case Qt::UserRole+5:
            return item->dataTime; //QDateTime::fromMSecsSinceEpoch(item->dataTime).toString("[yyyy-MM-dd] hh:mm:ss");
        case Qt::UserRole+6:
            return item->type;
        case Qt::UserRole+7:
           return item->type;
        //文本类型
        case Qt::UserRole+100:
        {
            TextData *textdata=static_cast<TextData*>(item.get());
            return textdata->text;
        }
        case Qt::UserRole+101:
        {
             TextData *textdata=static_cast<TextData*>(item.get());
             return textdata->isURL;
        }
        //图片
        case Qt::UserRole+200:
        {
            ImageData *imagedata=static_cast<ImageData *>(item.get());
            return imagedata->imgurl;
        }
        //gif
        case Qt::UserRole+232:
        {
            GIFData *gifdata=static_cast<GIFData *>(item.get());
            return gifdata->gifurl;
        }
        //音频
        case Qt::UserRole+300:
        {
            AudioData *audiodata=static_cast<AudioData *>(item.get());
            return audiodata->audiourl;
        }
        //视频
        case Qt::UserRole+400:
        {
            VideoData *videodata=static_cast< VideoData *>(item.get());
            return videodata->videourl;
        }
        case Qt::UserRole+500:
        {
             FileData *filedata=static_cast<FileData *>(item.get());
             return filedata->fileurl;
        }
    }
    return QVariant();
}
QHash<int, QByteArray> ChatListModel::roleNames() const
{
    return QHash<int, QByteArray>{
        { Qt::UserRole+0, "isUser"},
        { Qt::UserRole+1, "userID" },
        { Qt::UserRole+2, "userName" },
        { Qt::UserRole+3, "senderID" },
        { Qt::UserRole+4, "senderName" },
        { Qt::UserRole+5, "dateTime" },
        { Qt::UserRole+6, "type" },
        { Qt::UserRole+7, "status" },
        //文本
        { Qt::UserRole+100, "textdata"},
        { Qt::UserRole+101, "isURL"},
        //图片
        { Qt::UserRole+200, "imgurl"},
        { Qt::UserRole+232, "gifurl"},
        //音频
        { Qt::UserRole+300,"audiourl"},
        //视频
        { Qt::UserRole+400, "videourl"},
        //文件
        { Qt::UserRole+500, "fileurl"}
    };
}
void ChatListModel::appendText(const bool &isUser,
                                                  const qint64 &userID,
                                                  const qint64 &senderID,
                                                  const QString &text,
                                                  const bool &isURL){
    TextData *textdata = new TextData;
    textdata->isUser=isUser;
    textdata->userID=userID;
    textdata->userName="</USER>";
    textdata->senderID=senderID;
    textdata->senderName="</SENDER>";
    textdata->dataTime=QDateTime::currentDateTime().toMSecsSinceEpoch();
    textdata->type=ChatData::Text;
    textdata->status=ChatData::ParseSuccess;
    textdata->text=text;
    textdata->isURL=isURL;

    beginInsertRows(QModelIndex(),chatList.count(),chatList.count());
    chatList.push_back(QSharedPointer<ChatDataBase>(textdata));
    endInsertRows();
}
void ChatListModel::appendImage(const bool &isUser,
                                                      const qint64 &userID,
                                                      const qint64 &senderID,
                                                      const QString &imgurl){
    ImageData *Imagedata = new ImageData;
    Imagedata->isUser=isUser;
    Imagedata->userID=userID;
    Imagedata->userName="</USER>";
    Imagedata->senderID=senderID;
    Imagedata->senderName="</SENDER>";
    Imagedata->dataTime=QDateTime::currentDateTime().toMSecsSinceEpoch();
    Imagedata->type=ChatData::Image;
    Imagedata->status=ChatData::ParseSuccess;
    Imagedata->imgurl=imgurl;

    beginInsertRows(QModelIndex(),chatList.count(),chatList.count());
    chatList.push_back(QSharedPointer<ChatDataBase>(Imagedata));
    endInsertRows();
}
void ChatListModel::appendGIF(const bool &isUser,
                                                 const qint64 &userID,
                                                 const qint64 &senderID,
                                                 const QString &gifurl){
    GIFData *gifdata = new GIFData;
    gifdata->isUser=isUser;
    gifdata->userID=userID;
    gifdata->userName="</USER>";
    gifdata->senderID=senderID;
    gifdata->senderName="</SENDER>";
    gifdata->dataTime=QDateTime::currentDateTime().toMSecsSinceEpoch();
    gifdata->type=ChatData::GIF;
    gifdata->status=ChatData::ParseSuccess;
    gifdata->gifurl=gifurl;

    beginInsertRows(QModelIndex(),chatList.count(),chatList.count());
    chatList.push_back(QSharedPointer<ChatDataBase>(gifdata));
    endInsertRows();
}
void ChatListModel::appendAudio(const bool &isUser,
                                                      const qint64 &userID,
                                                      const qint64 &senderID,
                                                      const QString &audiourl){
    AudioData *audiodata = new AudioData;
    audiodata->isUser=isUser;
    audiodata->userID=userID;
    audiodata->userName="</USER>";
    audiodata->senderID=senderID;
    audiodata->senderName="</SENDER>";
    audiodata->dataTime=QDateTime::currentDateTime().toMSecsSinceEpoch();
    audiodata->type=ChatData::Audio;
    audiodata->status=ChatData::ParseSuccess;
    audiodata->audiourl=audiourl;

    beginInsertRows(QModelIndex(),chatList.count(),chatList.count());
    chatList.push_back(QSharedPointer<ChatDataBase>(audiodata));
    endInsertRows();
}

void ChatListModel::appendVideo(const bool &isUser,
                                                      const qint64 &userID,
                                                      const qint64 &senderID,
                                                      const QString &videourl){
    VideoData *videodata = new VideoData;
    videodata->isUser=isUser;
    videodata->userID=userID;
    videodata->userName="</USER>";
    videodata->senderID=senderID;
    videodata->senderName="</SENDER>";
    videodata->dataTime=QDateTime::currentDateTime().toMSecsSinceEpoch();
    videodata->type=ChatData::Video;
    videodata->status=ChatData::ParseSuccess;
    videodata->videourl=videourl;

    beginInsertRows(QModelIndex(),chatList.count(),chatList.count());
    chatList.push_back(QSharedPointer<ChatDataBase>(videodata));
    endInsertRows();
}
void ChatListModel::appendFile(const bool &isUser,
                                                  const qint64 &userID,
                                                  const qint64 &senderID,
                                                  const QString &fileurl){
    FileData *filedata = new FileData;
    filedata->isUser=isUser;
    filedata->userID=userID;
    filedata->userName="</USER>";
    filedata->senderID=senderID;
    filedata->senderName="</SENDER>";
    filedata->dataTime=QDateTime::currentDateTime().toMSecsSinceEpoch();
    filedata->type=ChatData::File;
    filedata->status=ChatData::ParseSuccess;
    filedata->fileurl=fileurl;

    beginInsertRows(QModelIndex(),chatList.count(),chatList.count());
    chatList.push_back(QSharedPointer<ChatDataBase>(filedata));
    endInsertRows();
}
void ChatListModel::clearData()
{
    beginResetModel();
    chatList.clear();
    endResetModel();
}

void ChatListModel::clearData(qint64 date){
    beginResetModel();
    foreach(QSharedPointer<ChatDataBase> Pointer,chatList){
        if(date==Pointer->type){
            chatList.removeOne(Pointer);
        }
    }
    endResetModel();
}
void ChatListModel::clearData(ChatData::DataType type){
    beginResetModel();
    foreach(QSharedPointer<ChatDataBase> Pointer,chatList){
        if(type==Pointer->type){
            chatList.removeOne(Pointer);
        }
    }
    endResetModel();
}
void ChatListModel::clearData(qint64 sdate,qint64 edate){
    beginResetModel();
    foreach(QSharedPointer<ChatDataBase> Pointer,chatList){
        if(edate<Pointer->dataTime && Pointer->dataTime <sdate){
            chatList.removeOne(Pointer);
        }
    }
    endResetModel();
}
ChatListModel::~ChatListModel(){

}
