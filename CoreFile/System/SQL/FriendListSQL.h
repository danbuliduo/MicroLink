#ifndef FRIENDLISTSQL_H
#define FRIENDLISTSQL_H

#include <QObject>
#include <QSqlError>
#include <QSqlDatabase>
#include <QSqlQuery>
class FriendListSQL : public QObject
{
    Q_OBJECT
public:
    explicit FriendListSQL(QObject *parent = nullptr);
    Q_INVOKABLE bool sql_CREATE_TABLE(QString tablename);
    Q_INVOKABLE bool sql_SELECT_Data(QString tablename, QString itemnam);
    Q_INVOKABLE bool sql_Loader_Data(QString tablename);
    Q_INVOKABLE bool sql_INSERT_Data(QString tablename,
                                                               qint64   timestamp,
                                                               QString dataowner,
                                                               QString datatype,
                                                               QString sectype,
                                                               QString url);
    Q_INVOKABLE bool sql_UPDATE_Data(QString tablename,QString data,QString id);
    Q_INVOKABLE bool sql_Delete_Data(QString tablename);
    Q_INVOKABLE bool sql_Delete_Data(QString tablename,qint64 stime,qint64 etime);
   // Q_INVOKABLE bool sql_Delete_Data(QString tablename,qint64 time);
signals:
    QString callLoaderData(QVariantMap dataMap);
private:
    QString PATH;
    QSqlDatabase db;
};

#endif // FRIENDLISTSQL_H
