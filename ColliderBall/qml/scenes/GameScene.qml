import Felgo 3.0
import QtQuick 2.2
import "../common"
import ".."
import"../control"
import "../entities"
import"../scenes"


//游戏界面
SceneBase {

    id:gameScene

    PhysicsWorld {
        id: world
        anchors.fill: parent
        updatesPerSecondForPhysics: 60
//       debugDrawVisible: true
    }

    // 当前关卡的文件名存储在这里，它用于加载
    property string activeLevelFileName

    // 当前加载的关卡存储
    property variant activeLevel

    property alias loader: loader


    // 设置当前关卡名字, 使加载器加载绑定的关卡
    function setLevel(fileName) {
        activeLevelFileName = fileName
    }

    // 背景
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "lightsteelblue"
    }

    // 运行时加载关卡
    Loader {
        id: loader
        source: activeLevelFileName != ""  ?  "../levels/" + activeLevelFileName : ""
        onLoaded: {

            // 没有在level项目本身中定义宽度和高度，所以在这里定义
            item.width = gameScene.width
            item.height = gameScene.height
            // 将加载的关卡存储为activeLevel，以便更容易地访问
            activeLevel = item

            console.log("当前关卡：" + activeLevelFileName)
        }
    }

    // 将gameScene链接到加载的关卡
    Connections {
        // 只有在加载级别时才连接，以防止错误
        target: activeLevel !== undefined ? activeLevel : null
    }
}
