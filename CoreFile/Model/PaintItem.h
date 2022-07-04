#ifndef PAINTITEM_H
#define PAINTITEM_H

#include <QQuickItem>
#include <QSGNode>
#include <QSGSimpleRectNode>
#include <QSGSimpleTextureNode>
#include <QQuickWindow>
#include <QImage>

class PaintItem : public QQuickItem
{
    Q_OBJECT
public:
    explicit PaintItem(QQuickItem *parent = nullptr);

public slots:
    void updateImage(const QImage &image);

protected:
    QSGNode * updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *) override;

private:
    QImage image;
};

#endif // PAINTITEM_H
