import QtQuick 2.0
import Felgo 3.0
import "../common" as Common

import ".."
import"../control"
import "../entities"
import"../scenes"

//关卡在gameScene被加载
Common.LevelBase {

    id:level3
    //    z:0
    //第三关
    levelName: "Level3"
    Image {
        id: levelbackground1
        x: 8
        y: -23
        z:-1
        anchors.leftMargin: 0
        anchors.topMargin: -49
        anchors.rightMargin: 0
        anchors.bottomMargin: -49
        anchors.fill:level3
        source: "../../assets/img/levelbackground1.png"
    }
    player{
                ball.originX:118
                ball.originY:500
    }
    Wall{
        x:28
        y:361
        width: 10
        height: 158
    }

    Wall {
        x: 168
        y: 429
        width: 10
        height: 90
    }

    Wall {
        x: 148
        y: 429
        width: 30
        height: 10
    }

    Wall {
        x: 148
        y: 389
        width: 10
        height: 50
    }

    Wall {
        x: 28
        y: 361
        width: 30
        height: 10
    }

    Wall {
        x: 48
        y: 71
        width: 10
        height: 300
    }

    Wall {
        x: 48
        y: 71
        width: 200
        height: 10
    }
    RedWall{
        x:148
        y:300
        width: 10
        height: 90
    }

    Wall {
        x: 238
        y: 71
        width: 10
        height: 50
    }

    Wall {
        x: 238
        y: 111
        width: 77
        height: 10
    }

    RedWall {
        x: 305
        y: 111
        width: 10
        height: 199
    }

    Wall {
        x: 148
        y: 300
        width: 167
        height: 10
    }

    Wall {
        x: 28
        y: 509
        width: 150
        height: 10
    }

    RedWall {
        x: 206
        y: 226
        width: 100
        height: 10
    }

    Turrent{
        id:turrent1
        x:72
        y:101
        width: 18
        height: 19
        rotation: 315
    }
    Timer{
        id:shootTimer1
        interval: 6000
        running: true
        repeat: true
        onTriggered: {
            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Bullet.qml"), {"x": turrent1.x+15, "y": turrent1.y-25})
        }

    }
    Wheel{
        id: wheel1
        x:68
        y:242
        width: 30
        height: 30
    }
    SequentialAnimation {
        running: true
        loops: Animation.Infinite
        PathAnimation {
            id: path1

            duration: 6000
            easing.type: Easing.Linear

            target: wheel1
            path: Path {
                startX: 68; startY: 242
                PathLine{
                    x:262
                    y:242
                }
            }
        }
        PathAnimation {
            id: path2

            duration: 6000
            easing.type: Easing.Linear

            target: wheel1
            path: Path {
                startX: 262; startY: 242
                PathLine{
                    x:62
                    y:242
                }
            }
        }
    }
    Turrent{
        id:turrent2
        x:250
        y:170
    }
    NumberAnimation{
        running: true
        loops: Animation.Infinite
        target: turrent2
        property: "rotation"
        from: 0
        to: 360
        duration: 6000
        easing.type:Easing.InBack
    }
    Laser{
        id:laser2
        x:turrent2.x
        y: turrent2.y
        z:-1
    }
    NumberAnimation{
        running: true
        loops: Animation.Infinite
        target: laser2
        property: "rotation"
        from: 0
        to: 360
        duration: 6000
        easing.type:Easing.InBack
    }

    RedWall {
        x: 28
        y: 409
        width: 70
        height: 13
    }

    RedWall {
        x: 68
        y: 470
        width: 10
        height: 49
    }
}

















/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
