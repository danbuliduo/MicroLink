#ifndef MOBILESENSOR_H
#define MOBILESENSOR_H
//---------------------------------------------------------------------------------------
//    Object: MobileSensor类    By: 邓明(D.Ming)    Date: 2022-01-16
//    功能：解析基础传感器数据，获取本机基本信息
//    备注：
//---------------------------------------------------------------------------------------
#include <QObject>
#include <QGeoPositionInfoSource>
#include <QGeoCoordinate>
#include <QGeoPositionInfo>
#include <QGyroscope>
#include <QAccelerometer>
#include<QMagnetometer>
#include<QLightSensor>
#include<QProximitySensor>
#include<QRotationSensor>

class MobileSensor : public QObject
{
    Q_OBJECT
public:
    explicit MobileSensor(QObject *parent = nullptr);
    Q_INVOKABLE void sensorInit();
    Q_INVOKABLE void sensordelete();
    Q_INVOKABLE double getGyroscope(int num);
    Q_INVOKABLE double getMagnetometer(int num);
    Q_INVOKABLE double getAccelerometer(int num);
    Q_INVOKABLE double getRotationSensor(int num);
    Q_INVOKABLE double getLightSensor();
    Q_INVOKABLE QString getProximitySensor();
    Q_INVOKABLE QString getGeoCoordinate(int num);
signals:
    void callPositionUpdated();
private slots:
    void PositionUpdated(const QGeoPositionInfo &info);
private:
    qreal x;
    qreal y;
    qreal z;
    double nowGroundSpeed=0.0;
    double nowVerticalSpeed=0.0;
    double nowMagneticVariation=0.0;
    double nowHorizontalAccuracy=0.0;
    double nowVerticalAccuracy=0.0;
    double nowLongitude=0.0;
    double nowLatitude=0.0;
    double nowDirection=0.0;
    QString nowTimes="";
    QGeoPositionInfoSource *source;

    //陀螺仪传感器
    QGyroscope *gyroscope;
    QGyroscopeReading *reader;
   //加速度传感器
    QAccelerometer *acceler;
    QAccelerometerReading *accelereader;
    //旋转传感器
    QRotationSensor *rotationSensor;
    QRotationReading *rotationReading;
   //电磁传感器
    QMagnetometer *magnetoMeter;
    QMagnetometerReading *magnetometerReading;
    //光强传感器
    QLightSensor *lightSensor;
    QLightReading *lightReading;
    //接近传感器
    QProximitySensor *proximitySensor;
    QProximityReading *proximityReading;
};

#endif // MOBILESENSOR_H
