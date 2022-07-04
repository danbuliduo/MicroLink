#include "MicroCVphotostudio.h"
#include "Obj_Nayuki_QRCode/QrCode.hpp"

#include <vector>
#include <string>

#include "./CoreFile/PublicClass/microimageprovider.h"


#include <opencv2/opencv.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/imgproc/types_c.h>

using namespace qrcodegen;

MicroCvPhotoStudio::MicroCvPhotoStudio(QObject *parent) : QObject{parent}
{
    qDebug()<<"MicroCvPhotoStudio()构造中";
    MicroLinkThread *work= new MicroLinkThread;
    work->moveToThread(&microThread);
    QObject::connect(this,&MicroCvPhotoStudio::startThread,work,&MicroLinkThread::Runcode);
    QObject::connect(work,&MicroLinkThread::callresultReady,this,&MicroCvPhotoStudio::imgGREY);
    QObject::connect(&microThread,&QThread::finished,this,&MicroCvPhotoStudio::DeleteThread);
    microThread.start();
}
MicroCvPhotoStudio::~MicroCvPhotoStudio(){
    qDebug()<<"MicroCvPhotoStudio()析构中";
    microThread.quit();
    microThread.wait();
}
void MicroCvPhotoStudio::DeleteThread(){
    microThread.quit();
    microThread.wait();
}
void MicroCvPhotoStudio::getPath(QString path){
    emit startThread(path);
}
void MicroCvPhotoStudio::setQrCode(QString data){
    std::vector<QrSegment> segs=QrSegment::makeSegments(data.toUtf8());
    QrCode qrcode=QrCode::encodeSegments(segs,QrCode::Ecc::HIGH,5,10,2,false);
    QImage qrcode_img=QImage(qrcode.getSize(),qrcode.getSize(),QImage::Format_RGB888);
    for(int y=0;y<qrcode.getSize();y++){
        for(int x=0;x<qrcode.getSize();x++){
            qrcode.getModule(x,y)==0 ? qrcode_img.setPixel(x,y,qRgb(255,255,255)) : qrcode_img.setPixel(x,y,qRgb(0,0,0));
        }
    }
     MicroImageProvider::setImage(qrcode_img);
     emit callQmlRefeshImg();
}

void MicroCvPhotoStudio::imgGREY(QString path){
    qDebug() << "threadID : "<<QThread::currentThread();;
    QImage image(path);
    cv::Mat matImg = cv::Mat(image.height(),image.width(),CV_8UC4,(void*)image.constBits(),image.bytesPerLine());
    cvtColor(matImg, matImg, CV_BGR2GRAY);
    image=QImage((const unsigned char*)(matImg.data),matImg.cols,matImg.rows,matImg.step,QImage::Format_Grayscale8);
    MicroImageProvider::setImage(image);
    emit callQmlRefeshImg();
}
