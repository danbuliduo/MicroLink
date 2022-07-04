#include "ItemListSQL.h"
#include <QJsonObject>
#include <QJsonDocument>
#include "./CoreFile/PublicClass/microlinkdefine.h"

ItemListSQL::ItemListSQL(QObject *parent) : QObject{parent},Tablename(TABLENAME)
{
    PATH = CURRENT_PATH"/USER/root/DataBase/";
    db=QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(PATH+"ItemsData.db");
    if(!db.open()){
        qDebug()<<"[ItemListSQL]:SQLError"<<db.lastError();
    }else{
        qDebug()<<"[ItemListSQL]:SQLOpen"<<db;
        sql_CREATE_TABLE();
    }
}
bool ItemListSQL::sql_CREATE_TABLE(){
    QSqlQuery query;
    QString sqlCreat=QString("CREATE TABLE "+Tablename+
                                             "("
                                                 "[ObjectID] varchar(16),"
                                                 "[ObjectKey] varchar(16),"
                                                 "[ObjectName] varchar(16),"
                                                 "[ObjectType] varchar(16),"
                                                 "[ObjectPath] varchar(256),"
                                                 "[CreatTime] varchar(32),"
                                                 "[CoreChip] varchar(16),"
                                                 "[Development] varchar(16)"
                                              ");");
    return query.exec(sqlCreat);
}

bool ItemListSQL::sql_INSERT_Data(QString objectid,
                                                       QString objectkey,
                                                       QString objectname,
                                                       QString objecttype,
                                                       QString objectpath,
                                                       QString creattime,
                                                       QString corechip,
                                                       QString development){
    QSqlQuery query;
    bool ok=query.prepare("INSERT INTO "+Tablename+
                          "(ObjectID, ObjectKey, ObjectName, ObjectType, ObjectPath, CreatTime, CoreChip, Development)"
                          "VALUES (:objectid,:objectkey,:objectname,:objecttype,:objectpath,:creattime,:corechip,:development)");
    query.bindValue(":objectid", objectid);
    query.bindValue(":objectkey",objectkey);
    query.bindValue(":objectname", objectname);
    query.bindValue(":objecttype", objecttype);
    query.bindValue(":objectpath", objectpath);
    query.bindValue(":creattime", creattime);
    query.bindValue(":corechip", corechip);
    query.bindValue(":development", development);

    if(!query.exec()){
        qDebug()<<"INSERTError:"<<query.lastError().text();
        ok=false;
    }
   return ok;
}
bool ItemListSQL::sql_DELETE_Data(QString key){
    QSqlQuery query;
    qDebug()<<"key"<<key;
    return query.exec("DELETE FROM "+Tablename+"WHERE [ObjectName] = '"+key+"'");
}
bool ItemListSQL::updateItem(){
    QSqlQuery query;
    bool ok=query.exec("SELECT * FROM "+Tablename);
    while(query.next()){
            QJsonObject jsonobj
            {
                {"ObjectID",query.value(0).toString()},
                {"ObjectKey",query.value(1).toString()},
                {"ObjectName",query.value(2).toString()},
                {"ObjectType",query.value(3).toString()},
                {"ObjectPath",query.value(4).toString()},
                {"CreatTime",query.value(5).toString()},
                {"CoreCHIP",query.value(6).toString()},
                {"Development",query.value(7).toString()}
            };
            emit callUpDdteItem(QJsonDocument(jsonobj).toJson());
    }
    return ok;
}

