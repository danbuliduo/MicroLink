#ifndef CHATLISTMODEL_H
#define CHATLISTMODEL_H

#include <QAbstractListModel>
#include "ChatListDefine.h"
class ChatListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ChatListModel(QObject *parent = nullptr);
    ~ChatListModel();
    //数据
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    //清空数据
    Q_INVOKABLE void clearData();
    Q_INVOKABLE void clearData(qint64 date);
    Q_INVOKABLE void clearData(ChatData::DataType type);
    Q_INVOKABLE void clearData(qint64 sdate,qint64 edate);
    //添加文本
    Q_INVOKABLE void appendText(const bool &isUser,
                                                      const qint64 &userID,
                                                      const qint64 &senderID,
                                                      const QString &text,
                                                      const bool &isURL);

    Q_INVOKABLE void appendImage(const bool &isUser,
                                                         const qint64 &userID,
                                                         const qint64 &senderID,
                                                         const QString &imgurl);

    Q_INVOKABLE void appendGIF(const bool &isUser,
                                                     const qint64 &userID,
                                                     const qint64 &senderID,
                                                     const QString &gifurl);
    Q_INVOKABLE void appendAudio(const bool &isUser,
                                                         const qint64 &userID,
                                                          const qint64 &senderID,
                                                         const QString &audiourl);
    Q_INVOKABLE void appendVideo(const bool &isUser,
                                                         const qint64 &userID,
                                                         const qint64 &senderID,
                                                         const QString &videourl);
    Q_INVOKABLE void appendFile(const bool &isUser,
                                                     const qint64 &userID,
                                                     const qint64 &senderID,
                                                     const QString &fileurl);
private:
    //数据
    QList<QSharedPointer<ChatDataBase>> chatList;
};

#endif // CHATLISTMODEL_H
