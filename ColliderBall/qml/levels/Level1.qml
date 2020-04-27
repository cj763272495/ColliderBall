import QtQuick 2.0
import Felgo 3.0
import "../common" as Common

import ".."
import"../control"
import "../entities"
import"../scenes"

//关卡在gameScene被加载
Common.LevelBase {

    id:level1
//    z:0
    //第一关
    levelName: "Level1"
    Image {
        id: levelbackground1
        x: 32
        z:-1
        anchors.leftMargin: 0
        anchors.topMargin: -49
        anchors.rightMargin: 0
        anchors.bottomMargin: -49
        anchors.fill:level1
        source: "../../assets/img/levelbackground1.png"
    }
//    BackgroundImage{
//        id:levelbackground1
//        anchors.fill:parent
//        source: "../../assets/img/levelbackground1.png"
//    }

    player{
        ball.originX:250
        ball.originY:450
    }

    Diamond{
        id:diamon
        diamondBody{
            width: 20
            height:20
        }

        x:50
        y:50
    }

    Wall{
        id: wall
        height: 199
        width: 10
        x:307
        y:310
    }

    Wall {
        id: wall1
        x: 205
        y: 371
        width: 10
        height: 138
    }
    RedWall{
        x:114
        y:371
        width:101
        height:10
    }

    Wall {
        id: wall2
        x: 114
        y: 191
        width: 10
        height: 190
    }

    RedWall {
        x: 307
        y: 254
        width: 10
        height: 100
    }

    RedWall {
        x: 217
        y: 254
        width: 100
        height: 10
    }

    RedWall {
        x: 217
        y: 191
        width: 10
        height: 73
    }

    Wall {
        id: wall3
        x: 32
        y: 191
        width: 92
        height: 10
    }

    Wall {
        id: wall4
        x: 32
        y: 0
        width: 285
        height: 10
    }

    Wall {
        id: wall5
        x: 32
        y: 0
        width: 9
        height: 201
    }

    Wall {
        id: wall6
        x: 307
        y: 0
        width: 10
        height: 201
    }

    Wall {
        id: wall7
        x: 217
        y: 191
        width: 100
        height: 10
    }

    Wall {
        id: wall8
        x: 205
        y: 499
        width: 112
        height: 10
    }

    RedWall {
        x: 89
        y: 99
        width: 170
        height: 10
    }
    Turrent{
        id:num
        x:154
        y:63
        width: 22
        height: 20
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
                startX: 55; startY: 124
                PathLine{
                    x:269
                    y:124
                }
            }
        }
        PathAnimation {
            id: path2

            duration: 3000
            easing.type: Easing.Linear

            target: wheel
            path: Path {
                startX: 269; startY: 124
                PathLine{
                    x:55
                    y:124
                }
            }
        }
    }
    Wheel{
        id:wheel
        x:55
        y:124
        width: 26
        height: 24
    }
}






















































/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
