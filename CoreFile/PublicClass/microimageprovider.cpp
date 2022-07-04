#include "microimageprovider.h"
QImage MicroImageProvider::m_image;
MicroImageProvider::MicroImageProvider()  : QQuickImageProvider(QQuickImageProvider::Image)
{

}
QImage MicroImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    qDebug()<<id<<size<<requestedSize;
    return m_image;
}
QPixmap MicroImageProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
     qDebug()<<id<<size<<requestedSize;
     return QPixmap::fromImage(m_image);
}
void MicroImageProvider::setImage(const QImage &image)
{
    qDebug()<<"ImageProvider::setImage"<<image;
    m_image = image;
}
