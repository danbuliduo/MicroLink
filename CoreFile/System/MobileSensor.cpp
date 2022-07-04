#include "MobileSensor.h"

MobileSensor::MobileSensor(QObject *parent) : QObject{parent}
{
}
void MobileSensor::sensorInit(){
    source=QGeoPositionInfoSource::createDefaultSource(this);
    if(source){
        connect(source, SIGNAL(positionUpdated(QGeoPositionInfo)),this, SLOT(positionUpdated(QGeoPositionInfo)));
        source->setUpdateInterval(100);
        source->startUpdates();
    }

    gyroscope = new QGyroscope(this);
    gyroscope->start();

    acceler = new QAccelerometer(this);
    acceler->setAccelerationMode(QAccelerometer::Combined);
    acceler->start();

    lightSensor = new QLightSensor(this);
    lightSensor->start();

    magnetoMeter = new QMagnetometer(this);
    magnetoMeter->start();

    proximitySensor = new QProximitySensor(this);
    proximitySensor->start();

    rotationSensor = new QRotationSensor(this);
    rotationSensor->start();
}
void MobileSensor::sensordelete(){
    if(source!=nullptr){
        delete source;
    }
    if(acceler!=nullptr){
        delete acceler;
    }
    if(gyroscope!=nullptr){
       delete gyroscope;
    }
    if(lightSensor!=nullptr){
        delete  lightSensor;
    }
    if(magnetoMeter!=nullptr){
        delete magnetoMeter;
    }
    if(proximitySensor!=nullptr){
        delete proximitySensor;
    }
    if(rotationSensor!=nullptr){
        delete rotationSensor;
    }
}
double MobileSensor::getLightSensor(){
    lightReading = lightSensor->reading();
    return lightReading->lux();
}
QString MobileSensor::getProximitySensor(){
    proximityReading = proximitySensor->reading();
    if(proximityReading->close()){
        return "接近";
    }else{
        return "远离";
    }
}
double MobileSensor::getGyroscope(int num){
    reader = gyroscope->reading();
    switch (num) {
         case 0: return reader->x();break;
         case 1: return reader->y();break;
         case 2: return reader->z();break;
    }
    return 0;
}
double MobileSensor::getAccelerometer(int num){
    accelereader = acceler->reading();
    switch (num) {
         case 0: return accelereader->x();break;
         case 1: return accelereader->y();break;
         case 2: return accelereader->z();break;
    }
    return 0;
}
double MobileSensor::getRotationSensor(int num){
    rotationReading = rotationSensor->reading();;
    switch (num) {
         case 0: return rotationReading->x();break;
         case 1: return rotationReading->y();break;
         case 2: return rotationReading->z();break;
    }
    return 0;
}
double MobileSensor::getMagnetometer(int num){
    magnetometerReading = magnetoMeter->reading();
    switch (num) {
         case 0: return magnetometerReading->x();break;
         case 1: return magnetometerReading->y();break;
         case 2: return magnetometerReading->z();break;
    }
    return 0;
}
QString MobileSensor::getGeoCoordinate(int num)
{
    switch (num) {
         case 0: return QString("%1").arg(nowLongitude); break;
         case 1: return QString("%1").arg(nowLatitude);break;
         case 6: return QString("%1").arg(nowHorizontalAccuracy);break;
    }
    return "";
}

void MobileSensor::PositionUpdated(const QGeoPositionInfo &info)
{
    nowLongitude = info.coordinate().longitude();        //经度
    nowLatitude = info.coordinate().latitude();              //纬度
    nowDirection = info.attribute(QGeoPositionInfo::Direction);
    nowGroundSpeed = info.attribute(QGeoPositionInfo::GroundSpeed);
    nowVerticalSpeed = info.attribute(QGeoPositionInfo::VerticalSpeed);
    nowMagneticVariation = info.attribute(QGeoPositionInfo::MagneticVariation);
    nowHorizontalAccuracy = info.attribute(QGeoPositionInfo::HorizontalAccuracy); //
    nowVerticalAccuracy = info.attribute(QGeoPositionInfo::VerticalAccuracy);
    nowTimes = info.timestamp().toString();        //GPS时间
    qDebug()<<nowLongitude<<nowLatitude;
    emit callPositionUpdated();
}
