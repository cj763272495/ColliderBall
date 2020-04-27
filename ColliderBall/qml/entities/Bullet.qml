import Felgo 3.0
import QtQuick 2.0

EntityBase {
    id: bulletEntity
    entityType: "bullet"
    entityId: "bullet"

    property point start
    property point velocity
    property int bulletType
    property alias circleCollider: circleCollider

    Image{
        id:bulletBody
//        anchors.bottom: bullet.bottom
//        anchors.horizontalCenter: bullet.horizontalCenter
//        anchors.topMargin: 80
        source: "../../assets/img/ball/redball.png"

        width: 15
        height: 15
    }
    CircleCollider{
        id:circleCollider
        radius:10
//        bodyType: Body.Static
        anchors.fill:parent
//        anchors.top:parent.top
//        anchors.topMargin: 35
//        anchors.left: parent.left
//        anchors.leftMargin: 15

        fixture.onBeginContact: {
            var fixture=other;
            var body=other.getBody();
            var otherEntity = body.target
            var collidingType=otherEntity.entityType
            if(collidingType==="wall"||collidingType==="ball"||collidingType==="redwall"){
                bulletEntity.removeEntity()
            }
        }
    }

    MovementAnimation{
        id:xAnim
        target:parent
        property: "x"
        //每秒变化的属性，例如初始为10,若值设为1,则下一秒为11
        velocity:50
        running: true
        onStopped: {
            bullet.destory()
        }
    }
    MovementAnimation{
        id:yAnim
        target:parent
        property: "y"
        velocity: 50
        running: true
        onStopped: {
            bullet.destory()
        }
    }
}
