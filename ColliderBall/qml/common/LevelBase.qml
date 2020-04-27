import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.3
import"../common"
import ".."
import"../control"
import "../entities"
import"../scenes"

//关卡内的基础
Item {
    id:levelBaseScene

    property alias player: player
    property alias ball: player.ball
    property alias timeText:countDown.text
    property string levelName

    property int vectory: 0
    property int gameOverSceneOpacity: 0
    property int time : 3

    //玩家
    Player{
        id:player
    }

    //玩家移动
    Move{
        enabled: (gameOverSceneOpacity || loadScene.opacity) <= 0

        z:2
        id:moveRed
        player: player

        ball:player.ball

        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: parent.height / 2
    }

    //玩家剩余生命值显示图片
    Image {
        z:4
        id: lifeImg
        width: 20
        height: 20
        source: "../../assets/img/ball/redball.png"
        anchors.left: parent.left
        anchors.top: parent.top
    }

    //显示玩家血量
    Text {
        z:4
        id: bloodTxt
        color: "white"
        font.pixelSize: 20
        anchors.left: lifeImg.right
        anchors.top: lifeImg.top
        text:"x" + player.life
    }

    //返回选择关卡按钮
    Rectangle {
        id: backimg
        color: "#36648B"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.rightMargin: 0
        anchors.right: parent.right
        border.color: "yellow"

        z:3
        width: 40
        height: 25

        Text {
            id: txt
            text: qsTr("返回")
            anchors.centerIn: parent
            color: "white"
            height: 25
            width: 20
        }

        //返回鼠标区域
        MouseArea{
            z:3         //置于最少层使按钮可被随时点击
            width: 30
            height: 30
            opacity: 1
            anchors.fill: parent
            hoverEnabled: true      //鼠标悬停，悬停允许处理所有鼠标事件，即使没有按下鼠标按钮。

            visible: parent.opacity > 0
            enabled: visible

            // 锚定向返回按钮
            anchors.right:parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top

            onClicked: {
                parent.scale = 1.0
                backButtonPressed()
                resetLevel()
                player.gameoverstop()
            }
            onPressed: {
                parent.scale = 0.85
                parent.opacity = 0.5
            }
            onReleased: {
                parent.scale = 1.0
                parent.opacity = 1
            }
            onCanceled: {
                parent.scale = 1.0
            }
        }
    }

    //重置所有游戏变量和玩家组件
    function resetLevel(){
        activeLevelFileName = ""

        gameOverSceneOpacity = 0
        //如果剩余生命值为小于0删除实体,显示游戏结束画布选择，否则重置小球位置
        var toRemoveEntityTypes = [""];

        entityManager.removeEntityById()

        console.log("resetlevel.....")
    }

    function restartLevel(){
        activeLevelFileName = "Level1.qml"

        gameOverSceneOpacity = 0
        console.log("gameOverSceneOpacity : " + gameOverSceneOpacity)
        //如果剩余生命值为小于0删除实体,显示游戏结束画布选择，否则重置小球位置
        console.log("restartlevel.....")
    }


    //加载游戏场景
    Rectangle{
        z:100
        id:loadScene
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        //        radius: 10
        opacity:time > 0? 1:0
        enabled: opacity

        Image {
            id: bg
            source: "../../assets/img/acitivitypage.png"
            anchors.fill: parent
        }

        //玩家剩余血量计时显示
        Text {
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 50
            id: countDown
            text: time
        }

        Timer{
            id:count
            repeat: true
            running: true
            interval: 1000
            onTriggered: {
                time --

                stopTimer()

            }
        }
    }
    function stopTimer(){
        if(timeText <= "0")
        {
            player.diamondNum.loadDiamond()
            count.stop()
            loadScene.opacity = 0
        }
    }



    //显示游戏结束的窗口
    Rectangle{
        z:100
        id:gameOverScene

        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        //        radius: 10
        opacity:gameOverSceneOpacity
        enabled: opacity
        Image {
            id: bg2
            source: "../../assets/img/acitivitypage.png"
            anchors.fill: parent
        }

        Text {
            id: continueTxt
            anchors.top: parent.top
            anchors.topMargin: 200
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("you have die")
            color: "white"
            font.pixelSize: 30
        }

        MenuButton{
            id:restart

            anchors.top: continueTxt.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: continueTxt.horizontalCenter

            text:qsTr("重新开始")
            txtcolor: "black"

            enabled: visible

            onClicked: {
                gameOverScene.opacity = 0
                console.log("重新开始游戏")

                console.log("visible: " + parent.visible)
                console.log("enabled: " + parent.enabled)
                gameOverSceneOpacity = 0
                player.life = 3
                restartLevel()
                player.gameoverstop()
                loadScene.opacity = 1
                time = 3
                count.restart()
            }
        }

        MenuButton{
            id:continueBtn

            anchors.top: restart.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: restart.horizontalCenter

            text:qsTr("取消")
            txtcolor: "black"

            onClicked: {
                gameOverScene.opacity = 0
                console.log("取消")
                backButtonPressed()
                gameOverSceneOpacity = 0
                player.life = 3
                player.gameoverstop()
                resetLevel()
                backButtonPressed()
                player.diamondNum.onDiamondChanged()
            }
        }
    }

    property alias remainLife: remainLife
    //显示生命值减去1
    Text {
        anchors.centerIn: parent

        id: remainLife
        text: player.life
        opacity: 0
        font.pixelSize: 50
        color: "white"
    }

    property alias remainTime: remainTime
    Timer{
        id:remainTime
        running: false
        repeat: false
        interval: 500
        onTriggered: {
            remainLife.opacity = 0
            remainLife.z = -1
        }
    }

    //游戏通关界面
    Item{
        id:continueGameScene
        Image{
            anchors.fill:parent
            source: "../../assets/img/acitivitypage.png"
        }
        anchors.fill: parent
        width: parent.width
        height: parent.height
        opacity: vectory
        enabled: opacity

        Text{
            id: namer
            text: qsTr("Congratulation !")
            font.pixelSize: 35
            color: "yellow"
            anchors.top: parent.top
            anchors.topMargin: 200
            anchors.horizontalCenter: parent.horizontalCenter
        }
//        MenuButton{
//            id:passRestart
//            anchors.top: namer.bottom
//            anchors.topMargin: 10
//            anchors.horizontalCenter: namer.horizontalCenter
//            text: qsTr("重新开始")
//            onClicked: {
//                continueGameScene.opacity=0
//                vectory=0
//                player.life=3
//            }
//        }
//        MenuButton{
//            id:nextBtn
//            text:qsTr("选择关卡")
//            anchors.centerIn: parent
//            onClicked: {
//                gameScene.backButtonPressed()
//            }
//        }
//        MenuButton{
//            id:homeBtn
//            text:qsTr("返回主界面")
//            anchors.top: nextBtn.bottom
//            anchors.horizontalCenter: nextBtn.horizontalCenter
//            onClicked: {
//            }
//        }
    }
}
