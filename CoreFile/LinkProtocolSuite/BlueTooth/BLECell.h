#ifndef BLECELL_H
#define BLECELL_H

#include <QObject>
#include<QBluetoothDeviceInfo>
#include <QLowEnergyService>
#include <QLowEnergyCharacteristic>
#include <QLowEnergyController>
#include <QMap>

class BLECell : public QObject
{
    Q_OBJECT
public:
    BLECell();
    ~BLECell();
    BLECell(QBluetoothDeviceInfo device, QObject *parent=nullptr);
    void connectToPublicDevice();
    void connectToRandomDevice();
    void disconnectFromDevice();

    void discoverServices();
    void connectService(QBluetoothUuid Uuid);
    void writeCharacteristic(QBluetoothUuid SUuid,QBluetoothUuid CUuid,QByteArray value);
    QLowEnergyService *getService(const QBluetoothUuid &Uuid);
    QLowEnergyCharacteristic getCharacteristic(const QBluetoothUuid &Uuid);
    QVariantList  getCharacteristicPermission(QLowEnergyCharacteristic Characteristic);
    QString getCharacteristicName(QLowEnergyCharacteristic Characteristic);
signals:
    void controllerConnected();
    void controllerConnectError(QLowEnergyController::Error newError);
    void controllerDisconnect();

    void discoverServicesFinished();

    void callAddService(QString Uuid,QString name);
    void callAddCharacteristic(QString Uuid,QString name);

    void characteristicChanged(const QLowEnergyCharacteristic &info,const QByteArray &value);
    void characteristicRead(const QLowEnergyCharacteristic &info,const QByteArray &value);
    void characteristicError(QLowEnergyService::ServiceError error);
public slots:
    void addService(const QBluetoothUuid &Uuid);
    void addCharacteristic(QLowEnergyService::ServiceState newState);
private:
    QBluetoothDeviceInfo Device;
    QLowEnergyController *Controller=nullptr;
    QMap <QBluetoothUuid, QLowEnergyService*> ServiceMap;
    QMap <QBluetoothUuid, QLowEnergyCharacteristic> CharacteristicMap;
};


#endif // BLECELL_H
