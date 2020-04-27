import Felgo 3.0
import QtQuick 2.0
import"../common"
import ".."
import"../control"
import "../entities"
import"../scenes"
import QtMultimedia 5.9
import DiaData 1.0

//玩家
EntityBase {
    id:player
    entityType: "player"

    property int life: 3
    property alias ball: ball
    property alias player: player

    //角色拥有的钻石数量
    property alias diamondNum: diamondNum
    Diamond{
        id:diamondNum
    }
    //signal RestartScenePlay

    Ball{
        id:ball
        rotation: 0
    }

    //球体被摧毁时播放声音
    SoundEffect{
        volume: 0.3
        id: balldestroyedsong
        source:""
    }

    //游戏结束音效
    MediaPlayer{
        id:gameoversound
        //playing: false
        volume: 1
        source: "../../assets/sond/GameOver.mp3"
    }

    //球体被摧毁，重新开始函数function
    function onDamagerestart(){

        //如果剩余生命值不为0,减去一滴生命
        if (gameOverSceneOpacity == 0){
            life = life-1
            if(life > 0){
                showRemianLife()
            }
            console.log("生命值减1, 剩余生命值： "+life)
            resetBall();
            console.log("钻石数量："+ GameData.diamondData)
        }

        //剩余生命低于0,结束游戏
        if (life == 0) {
            console.log("剩余生命值为" + life + "游戏结束")
            gameOverSceneOpacity  = 1
            console.log("gameOver: " + gameOverSceneOpacity)
            endGame()
        }
    }

    //游戏结束
    function endGame(){
        gameOverSceneOpacity = 1            //设置gameoverScene是否可见
        gameOverScene.z  = 2    //设置按钮可点

        gameOverScene.opacity = gameOverSceneOpacity   //设置
        console.log("gameOverSceneOpacity: " + gameOverSceneOpacity)
        console.log("游戏结束")       //测试

        gameoversound.play()        //播放结束音效
    }

    //停止播放游戏结束音效
    function gameoverstop(){
        gameoversound.stop()
    }

    //重置玩家变量  并重置位置
    function resetBall(){
        ball.x = ball.originX;
        ball.y = ball.originY;

        //小球速度归零
        ball.controller.xAxis = 0
        ball.controller.yAxis = 0

        console.log("reset ball")
    }

    function showRemianLife(){
        remainLife.opacity = 1
        remainLife.z = 100
        remainTime.start();
    }
}
