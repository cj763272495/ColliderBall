import Felgo 3.0
import QtQuick 2.0
import"../common"
import ".."
import"../control"
import "../entities"
import"../scenes"

EntityBase {
    id: entity
    entityType: "wall"
    entityId: "wall"

    BoxCollider {
        id: boxCollider
        bodyType: Body.Static
        //默认的，碰撞器大小与实体大小相同
    }

    //墙体设置
    Rectangle {
        anchors.fill: parent
        color: "#00B2EE"
        visible: true
        border.color: "#00FFFF"
    }
}
