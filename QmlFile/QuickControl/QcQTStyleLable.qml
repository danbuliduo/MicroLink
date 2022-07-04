import QtQuick
Image{
    id:root
    sourceSize: Qt.size(120,90)
    //source: "qrc:/images/Resources/Image/qt-style-back.png"
    Text{
       text: "Qt"
       anchors.centerIn: parent
       color: "white"
       font.pixelSize: 24
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            console.log("ok")
        }
    }
}
