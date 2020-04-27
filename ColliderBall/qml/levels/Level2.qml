import QtQuick 2.0
import Felgo 3.0
import "../common" as Common

import ".."
import"../control"
import "../entities"
import"../scenes"

//关卡在gameScene被加载
Common.LevelBase {

    id:level2
    //第二关
    levelName: "Level2"
    Image {
        id: levelbackground2
        anchors.rightMargin: 0
        anchors.topMargin: -49
        anchors.bottomMargin: -49
        anchors.fill: parent
        z:-1
        source: "../../assets/img/levelbackground2.png"
    }
    player{
        ball.originX:100
        ball.originY:450
    }
    Diamond{
        id:diamon
        diamondBody{
            width: 20
            height:20
        }
        x:100
        y:80
    }

    Wall{
        height: 280
        width: 10
        x:266
        y:225
    }

    Wall {
        x: 55
        y: 225
        width: 10
        height: 280
    }

    Wall {
        x: 55
        y: 225
        width: 67
        height: 10
    }

    Wall {
        x: 209
        y: 225
        width: 67
        height: 10
    }

    Wall {
        x: 209
        y: 134
        width: 10
        height: 101
    }

    Wall {
        x: 112
        y: 134
        width: 10
        height: 101
    }

    Wall {
        x: 55
        y: 134
        width: 67
        height: 10
    }

    Wall {
        x: 209
        y: 134
        width: 67
        height: 10
    }

    Wall {
        x: 55
        y: 8
        width: 10
        height: 136
    }

    Wall {
        x: 266
        y: 8
        width: 10
        height: 136
    }

    Wall {
        x: 55
        y: 8
        width: 221
        height: 10
    }
    RedWall{
        x: 55
        y: 302
        width: 71
        height: 10
    }

    RedWall {
        x: 205
        y: 366
        width: 71
        height: 10
    }
    Wheel{
        id:wheel
        x: 71
        y: 98
        width: 30
        height: 30
    }
    SequentialAnimation {
        running: true
        loops: Animation.Infinite
        PathAnimation {
            id: path1

            duration: 3000
            easing.type: Easing.Linear

            target: wheel
            path: Path {
                startX: 71; startY: 98
                PathLine{
                    x:230
                    y:98
                }
            }
        }
        PathAnimation {
            id: path2

            duration: 3000
            easing.type: Easing.Linear

            target: wheel
            path: Path {
                startX: 230; startY: 98
                PathLine{
                    x:71
                    y:98
                }
            }
        }
    }
    Bullet{
        id:bullet
        x:turrent1.x
        y:turrent1.y
    }

    Turrent{
        id:turrent1
        x:83
        y:344
        width: 18
        height: 19
        rotation: 315
    }
    Timer{
        id:shootTimer1
        interval: 3000
        running: true
        repeat: true
        onTriggered: {
             entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Bullet.qml"), {"x": turrent1.x+15, "y": turrent1.y})
        }
    }

    Turrent{
        id:turrent2
        x:226
        y:260
        width: 18
        height: 19
    }

    Wall {
        x: 55
        y: 495
        width: 221
        height: 10
    }
//    Timer{
//        id:shootTimer2
//        interval: 6000
//        running: true
//        repeat: true
//        onTriggered: {
//             entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Bullet.qml"), {"x": turrent2.x+15, "y": turrent2.y-25})
//        }
//    }
}






























/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
