import Felgo 3.0
import QtQuick 2.0
import"../common"
import ".."
import"../control"
import "../entities"
import"../scenes"


EntityBase {
    id:ballEntity
    entityType: "ball"
    entityId: "ball"

    x: originX
    y: originY

    property alias controller: twoAxisController
    property alias circleCollider: circleCollider
    property double originX
    property double originY

    // 这个控制帮助控制角色移动
    TwoAxisController {
        id: twoAxisController

        // 提供按下时的逻辑功能 (预判线方向改变，子弹时间)
        //onInputActionPressed: handleInputAction(actionName)
    }

    //球体的可视体
    Rectangle {
        height: 16
        width: 16
        radius: 10
        id: ballbody
        anchors.centerIn: parent

        border.color: "lightyellow"
        border.width: 2
        color: GameData.ballColor  //(颜色，可改变，皮肤功能实现，商城)
    }

    //球体物理特性
    CircleCollider {
        x:-radius
        y:-radius
        height: 16
        width: 16
        id:circleCollider

        radius: 10                  //circle半径
        //density: 0.02             //密度
        friction: 0                 //摩擦力

        restitution: 1              //完全弹性碰撞
        body.linearDamping: 0      //线性阻尼，摩擦力（值越小跳动越厉害）
        body.angularDamping: 15     //角阻尼，（值越小转动越快）

        fixture.onBeginContact: {
            console.log("ball contact")
            var fixture = other;
            var body = other.getBody();
            var otherEntity = body.target

            // get the entityType of the colliding entity
            var collidingType = otherEntity.entityType

            if(collidingType === "redwall" || collidingType === "wheel" || collidingType ==="bullet") {

                onDamagerestart();
                return
            }

            if(collidingType === "diamond"){
                gameVc()
                player.diamondNum.diamond++
                player.diamondNum.saveDiamond()
                GameData.diamondData = player.diamondNum.loadDiamond()

                console.log("contact  :  " + player.diamondNum.diamond);

                console.log("gameVc: " + vectory)
            }
        }

        function gameVc(){
            vectory = 100
            continueGameScene.z = 2
            resetBall()
    }

        //更新物理标记，线性速度
        linearVelocity: Qt.point(controller.xAxis * 100, controller.yAxis * (-100))

        //球体碰撞声音
//        SoundEffect{
//            volume: 0.3
//            id: colliderSound
//            source: "../../assets/sond/"
//        }
        //球体碰撞粒子效果
    }
}
