#include "BLECell.h"

BLECell::BLECell(){}
BLECell::BLECell(QBluetoothDeviceInfo device,QObject *parent)  : QObject{parent}
{
    this->Device=device;
}

void BLECell::connectToPublicDevice(){
    Controller = QLowEnergyController::createCentral(Device);

    connect(Controller,&QLowEnergyController::connected,
            this,&BLECell::controllerConnected);
    connect(Controller,&QLowEnergyController::errorOccurred,
            this,&BLECell::controllerConnectError);
    connect(Controller,&QLowEnergyController::disconnected,
            this,&BLECell::controllerDisconnect);

    Controller->setRemoteAddressType(QLowEnergyController::PublicAddress);
    Controller->connectToDevice();
}

void BLECell::connectToRandomDevice(){
    Controller = QLowEnergyController::createCentral(Device);

    connect(Controller,&QLowEnergyController::connected,
            this,&BLECell::controllerConnected);
    connect(Controller,&QLowEnergyController::errorOccurred,
            this,&BLECell::controllerConnectError);
    connect(Controller,&QLowEnergyController::disconnected,
            this,&BLECell::controllerDisconnect);

    Controller->setRemoteAddressType(QLowEnergyController::RandomAddress);
    Controller->connectToDevice();
}

void BLECell::disconnectFromDevice(){
    if(Controller->state() != QLowEnergyController::UnconnectedState){
        Controller->disconnectFromDevice();
        Controller->deleteLater();
        qDeleteAll(ServiceMap);
        ServiceMap.clear();
        CharacteristicMap.clear();
    }
}

void BLECell::discoverServices(){

    connect(Controller, &QLowEnergyController::serviceDiscovered,
            this, &BLECell::addService);
    connect(Controller, &QLowEnergyController::discoveryFinished,
            this, &BLECell::discoverServicesFinished);

    Controller->discoverServices();
}

void BLECell::connectService(QBluetoothUuid Uuid){
    if(ServiceMap.value(Uuid)->state()==QLowEnergyService::RemoteService){
       connect(ServiceMap.value(Uuid), &QLowEnergyService::stateChanged,
               this, &BLECell::addCharacteristic);
       connect(ServiceMap.value(Uuid),&QLowEnergyService::characteristicChanged,
               this,&BLECell::characteristicChanged);
       connect(ServiceMap.value(Uuid),&QLowEnergyService::characteristicRead,
               this,&BLECell::characteristicRead);
       connect(ServiceMap.value(Uuid),&QLowEnergyService::errorOccurred,
               this,&BLECell::characteristicError);
      ServiceMap.value(Uuid)->discoverDetails();
    }
}

void BLECell::addService(const QBluetoothUuid &Uuid){
    ServiceMap.insert(Uuid, Controller->createServiceObject(Uuid,this));
    emit callAddService(Uuid.toString(),ServiceMap.value(Uuid)->serviceName());
}

void BLECell::addCharacteristic(QLowEnergyService::ServiceState newState){
    if(newState==QLowEnergyService::RemoteServiceDiscovered){
        //qobject_cast<QLowEnergyService *>(sender())：回推发送信号的来源
        QLowEnergyService *service =  qobject_cast<QLowEnergyService *>(sender());
        foreach(QLowEnergyCharacteristic Characteristic,service->characteristics()){
            CharacteristicMap.insert(Characteristic.uuid(),Characteristic);
            qDebug()<<Characteristic.properties();
            foreach(QLowEnergyDescriptor des,Characteristic.descriptors()){
                qDebug()<<des.uuid()<<des.type()<<des.name();
            }
            emit callAddCharacteristic(Characteristic.uuid().toString(),getCharacteristicName(Characteristic));
        }
    }
}

void BLECell::writeCharacteristic(QBluetoothUuid SUuid,QBluetoothUuid CUuid,QByteArray value){
    ServiceMap.value(SUuid)->writeCharacteristic(CharacteristicMap.value(CUuid),value);
}

QLowEnergyService *BLECell::getService(const QBluetoothUuid &Uuid){
    return ServiceMap.value(Uuid);
}
QLowEnergyCharacteristic BLECell::getCharacteristic(const QBluetoothUuid &Uuid){
    return CharacteristicMap.value(Uuid);
}

QString BLECell::getCharacteristicName(QLowEnergyCharacteristic Characteristic){
    QString name = Characteristic.name();
    if(!name.isEmpty()){
        return name;
    }
    const QList<QLowEnergyDescriptor> descriptors = Characteristic.descriptors();
    for (const QLowEnergyDescriptor &descriptor : descriptors) {
        if (descriptor.type() == QBluetoothUuid::DescriptorType::CharacteristicUserDescription) {
            name = descriptor.value();
            break;
        }
    }
   return name.isEmpty() ? "Unknown" : name;
}

QVariantList  BLECell::getCharacteristicPermission(QLowEnergyCharacteristic Characteristic){
    QVariantList  PMList;
    uint permission = Characteristic.properties();
    if (permission & QLowEnergyCharacteristic::Read)
        PMList.push_back(QStringLiteral("Read"));
    if (permission & QLowEnergyCharacteristic::Write)
        PMList.push_back(QStringLiteral("Write"));
    if (permission & QLowEnergyCharacteristic::Notify)
        PMList.push_back(QStringLiteral("Notify"));
    if (permission & QLowEnergyCharacteristic::Indicate)
        PMList.push_back(QStringLiteral("Indicate"));
    if (permission & QLowEnergyCharacteristic::ExtendedProperty)
        PMList.push_back(QStringLiteral("ExtendedProperty"));
    if (permission & QLowEnergyCharacteristic::Broadcasting)
        PMList.push_back(QStringLiteral("Broadcast"));
    if (permission & QLowEnergyCharacteristic::WriteNoResponse)
        PMList.push_back(QStringLiteral("WriteNoResp"));
    if (permission & QLowEnergyCharacteristic::WriteSigned)
        PMList.push_back(QStringLiteral("WriteSigned "));
    return PMList;
}

BLECell::~BLECell(){
    qDeleteAll(ServiceMap);
    ServiceMap.clear();
    CharacteristicMap.clear();
    Controller->deleteLater();
}

