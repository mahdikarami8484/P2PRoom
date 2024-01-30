import QtQuick 5.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 200
    title: "Hello World"

    Item {
        anchors.fill: parent

        Text {
            anchors.centerIn: parent
            text: "Hello, World!"
            font.pointSize: 20
        }
    }
}
