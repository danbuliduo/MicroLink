#include "LinkVideoFrame.h"

LinkVideoFrame::LinkVideoFrame(PaintItem *parent) : PaintItem(parent)
{
    QImage img=QImage("qrc:/ImageFile/BUG.png");
    qDebug()<<img;
    updateImage(img);
}
void LinkVideoFrame::setImage(QString path){
    updateImage(QImage(path));
}
