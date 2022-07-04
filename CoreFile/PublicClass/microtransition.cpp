#include "microtransition.h"

MicroTransition::MicroTransition()
{

}
QString MicroTransition::TFileSize(const qint64 &size,const qint64 &acc){
        double value = (double)size;
        QStringList list;
        list << "KB" << "MB" << "GB" << "TB";

        QStringListIterator iterator(list);
        QString unit("B");

        while(value >= 1024.0 && iterator.hasNext()){
             unit = iterator.next();
             value /= 1024.0;
        }
        return QString().setNum(value,'f',acc)+" "+unit;
}
