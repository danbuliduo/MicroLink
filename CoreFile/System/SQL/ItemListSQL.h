#ifndef ITEMLISTSQL_H
#define ITEMLISTSQL_H

#include <QObject>
#include <QSqlError>
#include <QSqlDatabase>
#include <QSqlQuery>

#define TABLENAME "[OBJECTS]"

class ItemListSQL : public QObject
{
    Q_OBJECT
public:
    explicit ItemListSQL(QObject *parent = nullptr);
    bool sql_CREATE_TABLE();
    Q_INVOKABLE bool sql_INSERT_Data(QString objectid,
                                                               QString objectkey,
                                                               QString objectname,
                                                               QString objecttype,
                                                               QString objectpath,
                                                               QString creattime,
                                                               QString corechip,
                                                               QString development);
    Q_INVOKABLE bool sql_DELETE_Data(QString key);
    Q_INVOKABLE bool updateItem();
signals:
    void callUpDdteItem(QString jsondata);
private:
    QString PATH;
    QString Tablename;
    QSqlDatabase db;
};

#endif // ITEMLISTSQL_H
