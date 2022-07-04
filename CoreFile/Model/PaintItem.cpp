#include "PaintItem.h"
PaintItem::PaintItem(QQuickItem *parent) : QQuickItem(parent)
{
    setFlag(ItemHasContents,true);
    image=QImage(":/Image/background.png");
}
void PaintItem::updateImage(const QImage &image){
    this->image=image;
    update();
}
QSGNode * PaintItem::updatePaintNode(QSGNode *oldNode, QQuickItem::UpdatePaintNodeData *)
{
    auto node = dynamic_cast<QSGSimpleTextureNode *>(oldNode);
    if(!node){
        node = new QSGSimpleTextureNode();
    }
    QSGTexture *m_texture = window()->createTextureFromImage(image, QQuickWindow::TextureIsOpaque);
    node->setOwnsTexture(true);
    node->setRect(boundingRect());
    node->markDirty(QSGNode::DirtyForceUpdate);
    node->setTexture(m_texture);
    return node;
}
