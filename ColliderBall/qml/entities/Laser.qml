import Felgo 3.0
import QtQuick 2.0
import QtGraphicalEffects 1.0

EntityBase {
    entityType: "laser"
    entityId: "laser"
    id:laserEntity

    property alias boxCollider:boxCollider

    Rectangle{
        id:line
        width: 1
        height:40
        color: "red"
        rotation: 0
        RectangularGlow{
            anchors.fill:line
            glowRadius: 6
            spread:0.2
            color: "red"
            cornerRadius: line.radius+glowRadius
        }
    }
    BoxCollider{
        id:boxCollider
        anchors.fill: line
        restitution: 0  //表示球不会反弹
        sensor: false   //只检测碰撞
        bodyType: Body.Static
    }
}



