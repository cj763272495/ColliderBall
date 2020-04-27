import Felgo 3.0
import QtQuick 2.0
import QtQuick.Particles 2.0

EntityBase {

    entityId: "turrent"
    entityType: "turrent"
    id:turrentEntity
    property alias turrentBody:turrentBody


    Image{
        id:turrentBody
        //        width:200
        //        height:200
        anchors.centerIn: parent
        source: "../../assets/img/turrent.png"
        scale: 0.3
    }
    CircleCollider{
        id:circleCollider
        bodyType: Body.Static
        radius:15
        x:-radius+7
        y:-radius+6

        fixture.onBeginContact: {
            var fixture=other;
            var body=other.getBody();
            var otherEntity = body.target
            var collidingType=otherEntity.entityType
            if(collidingType==="ball"){
                turrentEntity.burstEmitter.emitRate = 16400
                particleTimer.start()
                colliderSound.play()
                turrentLifeTime.start()
                turrentEntity.removeEntity()
            }
        }
    }

    Timer{
        id:turrentLifeTime
        running: false
        repeat: false
        interval: 1000
        onTriggered: {
            turrentEntity.removeEntity()
        }
    }

    Timer{
        id:particleTimer
        running: false
        repeat: false
        interval:1000
        onTriggered: {
            turrentEntity.burstEmitter.emitRate = 0
        }
    }

    //碰撞粒子效果
    ParticleSystem{
        id:brustParticle
    }
    ImageParticle{
        system: brustParticle
        source: "qrc:///particleresources/glowdot.png"
        //颜色变化，应用于单个粒子的颜色变化
        colorVariation: 0.4
        color: "#FFA500"
    }
    //发射器
    property alias burstEmitter: burstEmitter
    Emitter{
        id:burstEmitter
        system:brustParticle
        x:parent.width/2
        y:parent.height/2
        //每秒发射粒子数
        emitRate: 0
        //一次发射器具有活动状态的最大粒子数
        maximumEmitted: 1000
        //发射粒子的开始加速度
        //疏散程度和角度
        acceleration: AngleDirection{magnitude: 120;angleVariation: 360}
        //粒子生命开始时大小
        size:16
        //粒子寿命结束时的大小
        endSize: 4
        //对单个粒子的大小和端点大小进行相同的随机添加
        sizeVariation: 4
    }

    //球体碰撞声音
    SoundEffect{
        volume: 1
        id: colliderSound
        source: "../../assets/sond/explosion.wav"
    }

}
