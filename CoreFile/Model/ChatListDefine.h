#ifndef CHATLISTDEFINE_H
#define CHATLISTDEFINE_H

#include <QObject>
#include <QSharedPointer>
class ChatData: public QObject
{
    Q_OBJECT
public:
    using QObject::QObject;
    enum DataType{
        //文本
        Text,
        //图片
        Image,
        //动图
        GIF,
        //音频
        Audio,
        //视频
        Video,
        //文件
        File,
        //链接
        URL
    };Q_ENUM(DataType)

    //数据处理状态
    enum DataStatus
    {
        //错误数据
        DataError,
        //待解析数据
        DataReady,
        //解析中数据
        ParseOn,
        //解析成功
        ParseSuccess,
        //解析失败
        ParseError
    };Q_ENUM(DataStatus)

};
//消息基类
struct ChatDataBase
{   //是否为用户发送
    bool isUser;
    //用户ID
    qint64 userID;
    //消息用户
    QString userName;
    //对象ID
    qint64 senderID;
    //发送对象
    QString senderName;
    //发送时间
    qint64 dataTime;
    //消息类型
    ChatData::DataType type=ChatData::Text;
    //处理状态
    ChatData::DataStatus status=ChatData::DataError;
    virtual ~ChatDataBase(){}
};

struct  TextData : public ChatDataBase
{
    QString text;
    bool isURL;
};
struct ImageData : public ChatDataBase
{
    QString imgurl;
};
struct GIFData : public ChatDataBase{
    QString gifurl;
};
struct  AudioData : public ChatDataBase{
    QString audiourl;
};
struct VideoData : public ChatDataBase{
    QString videourl;
};
struct FileData : public ChatDataBase{
    QString fileurl;
};

#endif // CHATLISTDEFINE_H
