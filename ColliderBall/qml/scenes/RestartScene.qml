import Felgo 3.0
import QtQuick 2.0
import "../common"
import ".."
import"../control"
import "../entities"
import"../scenes"

SceneBase{
    id:restartScene
    width: 50
    height: 50
    anchors.centerIn: parent.Center

    opacity: 0
    Rectangle{
        //玩家剩余生命值显示图片
        Image {
            z:4
            id: lifeImg
            width: 20
            height: 20
            source: "../../assets/img/ball2.png"
            anchors.left: parent.left
            anchors.top: parent.top
        }

        //显示玩家血量
        Text {
            z:4
            id: bloodTxt
            color: "red"
            font.pixelSize: 20
            anchors.left: lifeImg.right
            anchors.top: lifeImg.top
            text:"x" + ball.life
        }
        anchors.fill: parent
        color: "red"
        Text {
            id: restartText
            text: qsTr("继续")
        }
    }

    Timer{
        id:restartTimer
        running: false

        interval: 5000
        onTriggered: {
            restartScene.opacity = 0
        }
    }
}
