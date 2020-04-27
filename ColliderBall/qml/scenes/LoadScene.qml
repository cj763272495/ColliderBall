import Felgo 3.0
import QtQuick 2.0
import "../common"
import ".."
import"../control"
import "../entities"
import"../scenes"
import QtGraphicalEffects 1.0

//加载界面
SceneBase{
    id:loadScene
    anchors.fill: parent

    Image{
        id:img
        anchors.fill: parent
        source: "../../assets/img/bg9.jpg"
    }

    Text {
        id: load
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 465

        text: qsTr("Loading")
        font.pixelSize: 30

        Text {
            color: "white"
            id: point1
            text: qsTr(".")
            font.pixelSize: 40

            opacity: 0
            anchors.left: load.right
            anchors.leftMargin: 10
            anchors.bottom: load.bottom
        }
        Text {
            id: point2
            color: "white"
            text: qsTr(".")
            font.pixelSize: 40

            opacity: 0
            anchors.left: point1.right
            anchors.leftMargin: 10
            anchors.bottom: point1.bottom
        }
        Text {
            id: point3
            color: "white"
            text: qsTr(".")
            font.pixelSize: 40

            opacity: 0
            anchors.left: point2.right
            anchors.leftMargin: 10
            anchors.bottom: point2.bottom
        }
    }

    //加载界面省略号的动画
    SequentialAnimation{        //顺序动画
        id:ani
        running: true
        loops: Animation.Infinite

        NumberAnimation{        //数字动画，opacity值的变化
            property: "opacity"
            target: point1
            duration: 500
            from: 0
            to: 1
        }
        NumberAnimation{
            property: "opacity"
            target: point2
            duration: 500
            from: 0
            to: 1
        }
        NumberAnimation{
            property: "opacity"
            target: point3
            duration: 500
            from: 0
            to: 1
        }
        NumberAnimation{
            property: "opacity"
            target: point1
            duration: 90
            from: 1
            to: 0
        }
        NumberAnimation{
            property: "opacity"
            target: point2
            duration: 90
            from: 1
            to: 0
        }
        NumberAnimation{
            property: "opacity"
            target: point3
            duration: 90
            from: 1
            to: 0
        }
    }
}
