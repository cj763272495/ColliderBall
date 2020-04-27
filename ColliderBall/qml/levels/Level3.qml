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
        source: "../../assets/img/levelbackground3.png"
    }
    player{
        ball.originX:125
        ball.originY:400
    }

    Wall{
        x:136
        y:360
        width: 10
        height: 136
    }

    Wall {
        x: 68
        y: 360
        width: 10
        height: 136
    }

    Wall {
        x: 20
        y: 360
        width: 58
        height: 10
    }

    Wall {
        x: 136
        y: 360
        width: 58
        height: 10
    }

    Wall {
        x: 184
        y: 234
        width: 10
        height: 136
    }

    Wall {
        x: 20
        y: 208
        width: 10
        height: 162
    }
    RedWall{
        width: 10
        height: 202
        x:20
        y:8
    }

    Wall {
        x: 20
        y: 8
        width: 202
        height: 10
    }

    Wall {
        x: 184
        y: 235
        width: 38
        height: 10
    }

    RedWall {
        x: 305
        y: 9
        width: 10
        height: 236
    }

    RedWall {
        x: 223
        y: 8
        width: 92
        height: 10
    }

    RedWall {
        x: 223
        y: 235
        width: 92
        height: 10
    }

    Wall {
        x: 68
        y: 486
        width: 78
        height: 10
    }
    Wheel{
        id: wheel1
        x:36
        y:324
        width: 30
        height: 30
    }
    Wall {
        x: 180
        y: 76
        width: 60
        height: 10
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
                startX: 36; startY: 324
                PathLine{
                    x:148
                    y:324
                }
            }
        }
        PathAnimation {
            id: path2

            duration: 6000
            easing.type: Easing.Linear

            target: wheel1
            path: Path {
                startX: 148; startY: 324
                PathLine{
                    x:36
                    y:324
                }
            }
        }
    }


    Wall {
        x: 180
        y: 122
        width: 60
        height: 10
    }

    Wall {
        x: 180
        y: 76
        width: 10
        height: 56
    }

    Wall {
        x: 230
        y: 76
        width: 10
        height: 56
    }
    Turrent{
        id:turrent1
        x:280
        y:40
    }
    NumberAnimation{
        running: true
        loops: Animation.Infinite
        target: turrent1
        property: "rotation"
        from: 0
        to: 90
        duration: 6000
        easing.type:Easing.OutQuint
    }
    Laser{
        id:laser1
        x:turrent1.x
        y: turrent1.y
        z:-1
    }
    NumberAnimation{
        running: true
        loops: Animation.Infinite
        target: laser1
        property: "rotation"
        from: 0
        to: 90
        duration: 6000
        easing.type:Easing.OutQuint
    }
    Turrent{
        id:turrent2
        x:115
        y:235
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

    Turrent{
        id:turrent3
        x:40
        y:40
        width: 18
        height: 19
        rotation: 315
    }
    Timer{
        id:shootTimer3
        interval: 6000
        running: true
        repeat: true
        onTriggered: {
             entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Bullet.qml"), {"x": turrent3.x+15, "y": turrent3.y-25})
        }
    }
}





































/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
