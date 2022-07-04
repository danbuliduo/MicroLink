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
import Qt5Compat.GraphicalEffects
Item{
    id: root
    width: 48
    height: 48
    property int radius: width/2
    property alias source: image.source
    property alias mipmap: image.mipmap
    property alias fillMode: image.fillMode
    property alias haveborder : mask.visible
    property color bordercolor : "#A0A0A0"
    property alias opacitymaskmargin: opacitymask.anchors.margins
    Image {
        id: image
        sourceSize: Qt.size(parent.width, parent.height)
        mipmap: true
        visible: false
    }
    Rectangle {
        id: mask
        anchors.fill: parent
        radius: root.radius
        border.width: 2
        border.color: root.bordercolor
        visible: false
    }
    OpacityMask{
        id:opacitymask
        anchors.fill: parent
        anchors.margins: 0
        source: image
        maskSource: mask
    }
}
