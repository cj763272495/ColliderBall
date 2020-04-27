import Felgo 3.0
import QtQuick 2.0
import QtGraphicalEffects 1.0

EntityBase {
    id:wheelEntity
    entityType: "wheel"
    entityId: "wheel"

    property alias wheelBody:wheelBody

    Image{
        id:wheelBody
        width: 30
        height: 30
        source: "../../assets/img/wheel.png"
    }

    CircleCollider{
        id:circleCollider
        radius: 15
        bodyType: Body.Static

    }
    NumberAnimation{
        loops: Animation.Infinite
        running: true
        target: wheelBody
        property: "rotation"
        from:0
        to:360
        duration: 3000
    }
}

