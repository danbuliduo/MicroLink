import QtQuick
import "qrc:/QmlFile/QuickControl/"
import "qrc:/QmlFile/AppSettings/"
QcTreeView {
    anchors.fill: parent
    radius: 2
    border.color: BaseSettings.accentcolor
    model:JSON.parse('[
            {
                "text":"1 one",
                "istitle":true,
                "subnodes":[
                    {"text":"1-1 two","istitle":true},
                    {
                        "text":"1-2 two",
                        "istitle":true,
                        "subnodes":[
                            {"text":"1-2-1 three","isoption":true},
                            {"text":"1-2-2 three","isoption":true}
                        ]
                    }
                ]
            },
            {
                "text":"2 one",
                "istitle":true,
                "subnodes":[
                    {"text":"2-1 two","istitle":true},
                    {
                        "text":"2-2 two",
                        "istitle":true,
                        "subnodes":[
                            {"text":"2-2-1 three","isoption":true},
                            {"text":"2-2-2 three","isoption":true}
                        ]
                    }
                ]
            },
            {
                "text":"3 one",
                "istitle":true,
                "subnodes":[
                    {"text":"3-1 two","istitle":true},
                    {"text":"3-2 two","istitle":true}
                ]
            }
        ]')
}
