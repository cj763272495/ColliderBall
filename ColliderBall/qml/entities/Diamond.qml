import Felgo 3.0
import QtQuick 2.0

EntityBase {
    id:diamondEntity
    entityType: "diamond"
    entityId: "diamond"

    property alias diamondBody:diamondBody

    Image{
        id:diamondBody
        width: 50
        height: 50
        source: "../../assets/img/diamond.jpg"
    }

    BoxCollider{
        id:circleCollider
        anchors.fill: diamondBody
        bodyType: Body.Static
        fixture.onBeginContact: {
            diamondEntity.removeEntity();
        }
    }
}
