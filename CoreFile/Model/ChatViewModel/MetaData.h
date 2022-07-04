#ifndef METADATA_H
#define METADATA_H

#include <QObject>
#include <QUrl>
#include <QSharedPointer>
class MetaData : public QObject
{
    Q_OBJECT
public:
    using QObject::QObject;
    enum DataType{
        //未定义
        Undefined,
        //文本
        Text,
        //图片
        Image,
        //音频
        Audio,
        //视频
        Video,
        //文件
        File,
    };Q_ENUM(DataType)
    enum DataStatus{
        //错误数据
        DataError,
        //数据待解析
        DataReady,
        //解析中数据
        ParseOn,
        //解析成功
        ParseSuccess,
        //解析失败
        ParseError
    };Q_ENUM(DataStatus)
};
struct BaseData
{
    qint64 senderID;
    qint64 receiverID;
    qint64 timeStamp;
    MetaData::DataType type = MetaData::Undefined;
    MetaData::DataStatus status = MetaData::DataReady;
    virtual ~BaseData(){}
};
struct TextData : public BaseData
{
    QString text;
};
struct ImageData : public BaseData
{
    QUrl imageURL;

};

#endif // METADATA_H
