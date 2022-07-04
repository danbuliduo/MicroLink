#ifndef BLUETOOTHCENTRAL_H
#define BLUETOOTHCENTRAL_H

#include "BLECell.h"
#include <QObject>
#include <QBluetoothLocalDevice>
#include <QBluetoothDeviceDiscoveryAgent>
class BlueToothCentral : public QObject
{
    Q_OBJECT
public:
    enum AddressType{
        PublicAddress,
        RandomAddress
    };Q_ENUM( AddressType);
    explicit BlueToothCentral(QObject *parent = nullptr);

    Q_INVOKABLE void openBlueTooth();
    Q_INVOKABLE void startScanDevice();
    Q_INVOKABLE void connectToDevice(QString address, BlueToothCentral::AddressType);
    Q_INVOKABLE void disconnectFromDevice(QString address);

    Q_INVOKABLE void startScanService(QString address);
    Q_INVOKABLE void connectToService(QString address,QString Uuid);

    Q_INVOKABLE void writeCharacteristic(QString address,QString SUuid,
                                                                 QString CUuid,QString value);
signals:
    void callScanDeviceFinished();
    void callAddNewDevice(QString address, QString name);
    void callDeviceConnectSucceed();
    void callDeviceConnectError(QString error);
    void callDeviceDisconnect();

    void callScanServiceFinished();
    void callAddNewService(QString Uuid,QString name);
    void callAddNewCharacteristic(QString Uuid,QString name);
public slots:
    void addNewDevice(const QBluetoothDeviceInfo &info);
    void deviceConnectError(QLowEnergyController::Error newError);

private:
    QBluetoothDeviceDiscoveryAgent *DiscoveryAgent=nullptr;
    QBluetoothLocalDevice *LocalDevice=nullptr;
    QMap<QString, BLECell *> BLECellMap;
};

#endif // BLUETOOTHCENTRAL_H
