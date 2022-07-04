//MicroLink::[https://github.com/mengps/QmlControls]
/*MIT License

Copyright (c) 2020 mengps

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
import QtQuick
Item{
    id: root
    property alias spread: back.spread                 //光圈强度
    property alias radius: back.radius                   //图像圆半径
    property alias glowRadius: back.glowRadius  //光圈半径
    property alias glowColor: back.color              //光圈颜色

    property alias source: image.source
    property alias fillMode: image.fillMode
    property alias haveborder : image.haveborder
    property alias bordercolor : image.bordercolor
    property alias opacitymaskmargin : image.opacitymaskmargin
    QcGlowRectangle
    {
        id: back
        anchors.fill: parent
        color: "black"          //默认为黑色
        glowColor: color
        QcCircularImage
        {
            id: image
            anchors.fill: parent
            radius: parent.radius
            mipmap: true
            antialiasing: true
        }
    }
}

