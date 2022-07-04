#include "FriendListSQL.h"
#include "./CoreFile/PublicClass/microlinkdefine.h"
FriendListSQL::FriendListSQL(QObject *parent) : QObject{parent}
{
     PATH = CURRENT_PATH"/USER/root/DataBase/";
     db=QSqlDatabase::addDatabase("QSQLITE");
     db.setDatabaseName(PATH+"FChatData.db");
     if(!db.open()){
         qDebug()<<"[FriendListSQL]:SQLError"<<db.lastError();
     }else{
         qDebug()<<"[FriendListSQL]:SQLOpen"<<db;
         sql_CREATE_TABLE("[Debug]");
     }
}

bool FriendListSQL::sql_CREATE_TABLE(QString tablename){
    QSqlQuery query;
    QString sqlCreat=QString("CREATE TABLE "+tablename+
                                             "("
                                                 "[ID] integer PRIMARY KEY AUTOINCREMENT,"
                                                 "[TimeStamp], integer,"
                                                 "[DataOwner] varchar(32),"
                                                 "[DataType] varchar(16),"
                                                 "[SecType] varchar(16),"
                                                 "[URL] varchar(4096)"
                                              ");");
    return query.exec(sqlCreat);
}
bool FriendListSQL::sql_INSERT_Data(QString tablename,
                                                          qint64   timestamp,
                                                          QString dataowner,
                                                          QString datatype,
                                                          QString sectype,
                                                          QString url){
    QSqlQuery query;
    bool ok=query.prepare("INSERT INTO "+tablename+
                          " (TimeStamp,DataOwner,DataType,SecType,URL)"
                          " VALUES (:timestamp,:dataowner,:datatype,:sectype,:url)");
    query.bindValue(":timestamp", timestamp);
    query.bindValue(":dataowner", dataowner);
    query.bindValue(":datatype", datatype);
    query.bindValue(":sectype", sectype);
    query.bindValue(":url", url);
    if(!query.exec()){
        qDebug()<<"INSERTError:"<<query.lastError().text();
        ok=false;
    }
    return ok;
}
bool FriendListSQL::sql_Loader_Data(QString tablename){
    QSqlQuery query;
    bool ok=query.exec("SELECT * FROM "+tablename);
    while(query.next()){
        QVariantMap dataMap;
        dataMap.insert("TimeStamp",query.value("TimeStamp"));
        dataMap.insert("DataOwner",query.value("DataOwner"));
        dataMap.insert("DataType",query.value("DataType"));
        dataMap.insert("SecType",query.value("SecType"));
        dataMap.insert("URL",query.value("URL"));
        emit callLoaderData(dataMap);
    }
    return ok;
}

bool FriendListSQL::sql_SELECT_Data(QString tablename,QString itemname){
    QSqlQuery query;
    bool ok=query.exec("SELECT "+itemname+" FROM "+tablename);
    while(query.next()){
            qDebug()<<query.value(itemname).toString();
    }
    return ok;
}

bool FriendListSQL::sql_UPDATE_Data(QString tablename,QString data,QString id){
    QSqlQuery query;
    QString sqlCreat=QString("UPDATE "+tablename+ "SET "+data+"WHERE ID = "+id+";");
    return query.exec(sqlCreat);
}

bool FriendListSQL::sql_Delete_Data(QString tablename){
    QSqlQuery query;
    bool ok=query.prepare("DELETE FROM "+tablename);
    if(!query.exec()){
        qDebug()<<"DELETE Error:"<<query.lastError().text();
        ok=false;
    }
    return ok;
}

bool FriendListSQL::sql_Delete_Data(QString tablename,qint64 stime,qint64 etime){
    QSqlQuery query;
     bool ok=query.prepare("DELETE FROM "+tablename+
                           "WHERE (TimeStamp<"+QStringLiteral("%1").arg(stime)+
                           " AND TimeStamp>"+QStringLiteral("%1").arg(etime)+")");
     return ok;
}
