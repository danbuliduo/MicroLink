#ifndef MICROIMAGEPROVIDER_H
#define MICROIMAGEPROVIDER_H

#include <QQuickImageProvider>
#include<QPixmap>
#include<QImage>
class MicroImageProvider : public QQuickImageProvider
{
public:
    MicroImageProvider();
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);
    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize);
    static void setImage(const QImage &image);
private:
    static QImage m_image;
};

#endif // MICROIMAGEPROVIDER_H
