import QtQuick 2.0
import "QRCode.js" as QRCodeBackend

Canvas {
    id: canvas
    // background colour to be used
    property color background : "white"
    // foreground colour to be used
    property color foreground : "black"
    // ECC level to be applied ( L,%7 M%15, Q%25, H%30)
    property string level : "L"
    // value to be encoded in the generated QR code
    property string value : ""
    property double size : 500
    property double padding: 25
    onPaint : {
        var qr = QRCodeBackend.get_qr()
        qr.canvas({
            background : canvas.background,
            canvas : canvas,
            value: canvas.value,
            foreground : canvas.foreground,
            level : canvas.level,
            side : Math.min(canvas.width, canvas.height),
            value : canvas.value,
            size : canvas.size,
            padding: canvas.padding
        })
    }
    onHeightChanged : {
        requestPaint()
    }

    onWidthChanged : {
        requestPaint()
    }

    onBackgroundChanged : {
        requestPaint()
    }

    onForegroundChanged : {
        requestPaint()
    }

    onLevelChanged : {
        requestPaint()
    }

    onValueChanged : {
        requestPaint()
    }
}
