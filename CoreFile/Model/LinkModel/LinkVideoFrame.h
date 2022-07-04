#ifndef LINKVIDEOFRAME_H
#define LINKVIDEOFRAME_H

#include<QObject>
#include "../PaintItem.h"
class LinkVideoFrame : public PaintItem
{
    Q_OBJECT
public:
    explicit LinkVideoFrame(PaintItem *parent=nullptr);
    Q_INVOKABLE void setImage(QString path);
};

#endif // LINKVIDEOFRAME_H
