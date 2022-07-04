#include "BlueToothCentral.h"

BlueToothCentral::BlueToothCentral(QObject *parent) : QObject{parent}
{
    LocalDevice = new QBluetoothLocalDevice();
    DiscoveryAgent = new QBluetoothDeviceDiscoveryAgent();
    connect(DiscoveryAgent,&QBluetoothDeviceDiscoveryAgent::deviceDiscovered,
            this,&BlueToothCentral::addNewDevice);
    connect(DiscoveryAgent,&QBluetoothDeviceDiscoveryAgent::finished,
            this,&BlueToothCentral::callScanDeviceFinished);
}
void BlueToothCentral::openBlueTooth(){
    LocalDevice->powerOn();
}
void BlueToothCentral::startScanDevice(){
    if(LocalDevice->hostMode() == QBluetoothLocalDevice::HostPoweredOff){
        LocalDevice->powerOn();
    }
    qDeleteAll(BLECellMap);
    BLECellMap.clear();
    DiscoveryAgent->start(QBluetoothDeviceDiscoveryAgent::LowEnergyMethod);
}

void BlueToothCentral::addNewDevice(const QBluetoothDeviceInfo &info){
    if(info.coreConfigurations() & QBluetoothDeviceInfo::LowEnergyCoreConfiguration){
        BLECell *BLEcell = new BLECell(info);
        BLECellMap.insert(info.address().toString(), BLEcell);
        emit callAddNewDevice(info.address().toString(), info.name());
    }
}

void BlueToothCentral::connectToDevice(QString address,AddressType type){
    connect(BLECellMap.value(address),&BLECell::controllerConnected,
            this,&BlueToothCentral::callDeviceConnectSucceed);
    connect(BLECellMap.value(address),&BLECell::controllerConnectError,
            this,&BlueToothCentral::deviceConnectError);
    connect(BLECellMap.value(address),&BLECell::controllerDisconnect,
            this,&BlueToothCentral::callDeviceDisconnect);
    if(type == BlueToothCentral::PublicAddress){
        BLECellMap.value(address)->connectToPublicDevice();
    }else if(type == BlueToothCentral::RandomAddress){
        BLECellMap.value(address)->connectToRandomDevice();
    }
}

void BlueToothCentral::disconnectFromDevice(QString address){
     BLECellMap.value(address)->disconnectFromDevice();
}

void BlueToothCentral::deviceConnectError(QLowEnergyController::Error newError){
    switch (newError) {
    case QLowEnergyController::NoError://无错误
        emit callDeviceConnectError(QStringLiteral("NoError"));
        return;
    case QLowEnergyController::UnknownError://未知错误
        emit callDeviceConnectError(QStringLiteral("UnknownError"));
        return;
    case QLowEnergyController::UnknownRemoteDeviceError://找不到远程蓝牙设备
        emit callDeviceConnectError(QStringLiteral("UnknownRemoteDeviceError"));
        return;
    case QLowEnergyController::NetworkError://读取或写入远程设备失败
        emit callDeviceConnectError(QStringLiteral("NetworkError"));
        return;
    case QLowEnergyController::InvalidBluetoothAdapterError://本地蓝牙设备错误
        emit callDeviceConnectError(QStringLiteral("InvalidBluetoothAdapterError"));
        return;
    case QLowEnergyController::ConnectionError://连接设备失败
        emit callDeviceConnectError(QStringLiteral("ConnectionError"));
        return;
    case QLowEnergyController::AdvertisingError://开始广告尝试失败
        emit callDeviceConnectError(QStringLiteral("AdvertisingError"));
        return;
    case QLowEnergyController::RemoteHostClosedError://远程设备关闭连接
        emit callDeviceConnectError(QStringLiteral("RemoteHostClosedError"));
        return;
    case QLowEnergyController::AuthorizationError://本地了蓝牙授权不足
        emit callDeviceConnectError(QStringLiteral("AuthorizationError"));
        return;
    }
}

void BlueToothCentral::startScanService(QString address){
    connect(BLECellMap.value(address),&BLECell::callAddService,
            this, &BlueToothCentral::callAddNewService);
    connect(BLECellMap.value(address),&BLECell::discoverServicesFinished,
            this, &BlueToothCentral::callScanServiceFinished);

    BLECellMap.value(address)->discoverServices();
}

void BlueToothCentral::connectToService(QString address,QString Uuid){
    connect(BLECellMap.value(address),&BLECell::callAddCharacteristic,
            this,&BlueToothCentral::callAddNewCharacteristic);
    BLECellMap.value(address)->connectService(QBluetoothUuid(Uuid));
}

void BlueToothCentral::writeCharacteristic(QString address,QString SUuid,
                                                        QString CUuid,QString value){
    QBluetoothUuid suuid(SUuid);
    QBluetoothUuid cuuid(CUuid);
    QByteArray data=QByteArray::fromHex(value.toUtf8());
    BLECellMap.value(address)->writeCharacteristic(suuid,cuuid,data);
}


