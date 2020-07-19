import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.5
import "../common" as Common
import ".."
import "../entities"
import "../control"
import "../levels"
import "../scenes"

// 玩家的控制区域整个游戏场景
Rectangle{
    id: move
    anchors.top: parent.top
    anchors.topMargin: 30       //为返回按钮留出点击区域
    anchors.bottom: parent.bottom
    color: "transparent"
    focus: true

    // 目标玩家和ball是从外面设置的
    property var player
    property var ball
    property double originX
    property double originY

    //此图像显示控制器  并用于计算玩家的移动
    Image {
        id: playerMovementImage
        source: "../../assets/img/光圈.png"
        z: 5
        width: 40
        height: 40
        x: originX
        y: originY
        opacity: 0
    }

    // 多点触控区域  覆盖几乎整个屏幕
    MultiPointTouchArea {

        id:touchArea
        z: -1
        anchors.fill: parent

        // referencepoint 是多点触摸区内 圆形控制器垫的中心
        property int referencePointX: 0
        property int referencePointY: 0

        // 释放鼠标或手指后，需要新的参考点
        property bool didRegisterReferencePoint: false;

        // 访问玩家的控制器来添加移动的计算
        property variant playerTwoAxisController: ball.getComponent("TwoAxisController")

        //新位置是从圆盘中心计算的点
        //值被转换  并在 1 和 -1 两个值 变化。
        //用于计算玩家的速度
        property real newPosX: 0.0
        property real newPosY: 0.0

        //触摸点
        touchPoints: [
            TouchPoint { id: fieldPoint }
        ]

        onUpdated: {

            //计算当前点 与 reference点 的差
            //结果是一个1左右的值，但是会被转换
            newPosX = ((fieldPoint.x - referencePointX + playerMovementImage.width / 2) / (playerMovementImage.width / 2) - 1)
            newPosY = ((fieldPoint.y - referencePointY + playerMovementImage.height / 2) / (playerMovementImage.height / 2) - 1)


            // 圆心与半径之间的距离
            var distance = Math.sqrt((newPosX*newPosX) + (newPosY*newPosY))

            //如果还没有加载参考点，则获取一个
            if (didRegisterReferencePoint == false) {
                // 注意有一个参考点
                didRegisterReferencePoint = true;

                // 保存新的点
                referencePointX = fieldPoint.x;
                referencePointY = fieldPoint.y;

                // 重新定位控件图像
                updatePlayerMovementImagePosition()
                return;
            }

            // 如果新点在运动控制圈之外
            if (distance > 1) {
                //角度用于在圆形垫的边界处查找参考点
                //计算两点之间的角度（零和新位置），并将其转换为度数和右坐标系
                var angle = (Math.atan2(newPosX, newPosY) * 180 / Math.PI) - 180
                angle = angle * (-1)
                angle -= 90

                //在摇杆的边界处找到新的点
                //从旧点开始，选择半径距离正确的新点
                var newX = (playerMovementImage.width / 2) * Math.cos((angle) * Math.PI / 180) + referencePointX   //根据角度换算出新点的x轴
                var newY = (playerMovementImage.height / 2) * Math.sin((angle) * Math.PI / 180) + referencePointY  //换算出新点的y轴

                //计算边界reference点与 圆盘外侧新摇杆点位置的差
                var diffX = fieldPoint.x - newX
                var diffY = fieldPoint.y - newY

                //计算圆形遥感 的新圆点
                //确保新的reference点为圆形遥感的图像留有足够的空间（半径）

                //如果新点距屏幕左边界的距离小于圆形摇杆的半径，那么新点距离左边界的距离就是图片半径
                if ((referencePointX + diffX) <= (playerMovementImage.width / 2)){
                    referencePointX = playerMovementImage.width / 2
                    //如果新点距屏幕右边界的距离小于圆形摇杆的半径，那么新点距离右边界的距离就是图片半径
                }else if ((referencePointX + diffX) >= (move.width - playerMovementImage.width/2)){
                    referencePointX = move.width - playerMovementImage.width/2
                    //否则X轴大小就是原先的X轴大小加上新点与旧点的距离
                }else{
                    referencePointX += diffX
                }

                //Y轴方法 同上X轴
                if ((referencePointY + diffY) <= playerMovementImage.height / 2){
                    referencePointY = playerMovementImage.height / 2
                }else if ((referencePointY + diffY) >= (move.height - playerMovementImage.height / 2)){
                    referencePointY = move.height - playerMovementImage.height / 2
                }else{
                    referencePointY += diffY
                }
            }

            //因为圆点在左上角，所以要改变y轴的方向
            newPosY = newPosY * -1          //使得向上划动小球上移，下划下移
        }

        //------------------------------重新定位摇杆图像位置----------------------------------------
        function updatePlayerMovementImagePosition() {
            //reference点为中心，减去摇杆半径，得到新点的x，y轴的大小
            var newX = referencePointX - playerMovementImage.width / 2;
            var newY = referencePointY - playerMovementImage.height / 2;


            //X、Y值必须满足条件。分别要大于等于摇杆图片半径，小于等于屏幕最大减去摇杆半径
            newX = Math.max(0, newX);
            newX = Math.min(move.width - playerMovementImage.width, newX);
            newY = Math.max(0, newY);
            newY = Math.min(move.height - playerMovementImage.height, newY);

            // 给控制图片分配新地点
            playerMovementImage.x = newX;
            playerMovementImage.y = newY;
        }


        //  ----------------------更新角色的速度和方向-------------------------------------
        function updateMovement(){
            var velocity = Math.sqrt(newPosX * newPosX + newPosY * newPosY)
            var maxVelocity = 4

            //规范化速度，到中心的水平和垂直最大距离为1
            //因为它是一个正方形多点触摸区，所以到中心的对角线距离可以大于1
            //规格化值以获得统一的最大速度
            if (velocity > maxVelocity) {
                var shrinkFactor = maxVelocity / velocity
                newPosX = newPosX * shrinkFactor
                newPosY = newPosY * shrinkFactor
            }


            //向控制器传入X、Y参数，更新运动方向和速度
            playerTwoAxisController.xAxis = newPosX
            playerTwoAxisController.yAxis = newPosY
        }

        // -------------------玩家放开鼠标或者松开手指------------------------------
        //放开时空减速消失，小球改变方向原速运动
        onReleased: {

            //放开控制图片消失
            playerMovementImage.opacity = 0
            // 下一个输入将是 新的参考点的 新接触点
            didRegisterReferencePoint = false;

            updatePlayerMovementImagePosition()
            // 调整速度
            newPosX = newPosX * 2
            newPosY = newPosY * 2

            // 更新运动
            updateMovement()
        }

        //按下时空减速
        onPressed: {
            //点击的时候控制图片显示
            playerMovementImage.opacity = 1

            updatePlayerMovementImagePosition()

            //时空减速乘以 0.01, 停止就乘以0
            newPosX = newPosX * 0.01
            newPosY = newPosY * 0.01

            // 更新运动
            updateMovement()

            console.log("touch point")
        }
    }
}
