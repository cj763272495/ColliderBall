import Felgo 3.0
import QtQuick 2.0
import"./common"
import ".."
import"./control"
import "./entities"
import"./scenes"
import"./menus"
import QtQuick.Controls 2.3
import DiaData 1.0

GameWindow {
    id: window
    screenWidth: 640
    screenHeight: 960
    visible: true

    //角色拥有的钻石数量
    property alias outdiamond: outdiamond

    property int diamondNum: outdiamond.diamond
    Diamond{
        id:outdiamond
    }

    //创建实体
    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    //菜单场景
    SwipeView{
        enabled: opacity
        id: menuScene
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        opacity: 0
        HomePage{
            id:page1
            //选择关卡被点击
            onSelectLevelPressed: {
                window.state = "selectLevel"        //状态设为选择关卡
            }
            onBackButtonPressed: {
                nativeUtils.displayMessageBox(qsTr("是否退出游戏?"), "" , 3);

            }
            // 监听MessageBox的返回值
            Connections {
                target: nativeUtils
                onMessageBoxFinished: {
                    // 只退出，如果当前场景为菜单场景，messageBox也会弹出
                    if(accepted && window.activeScene === menuScene)
                        Qt.quit()
                }
            }
        }

        StorePage{
            id:page2
        }
        ActivityPage{
            id:page3
        }
        SettingPage{
            id:page4
        }
    }

    //menu界面下面的四个TabBar
    TabBar{
        id:tabBar

        anchors.bottom: window.bottom
        anchors.bottomMargin: 0
        width:window.width
        contentHeight :window.height/10
        //        height: window.height/12
        currentIndex: menuScene.currentIndex
        y:parent.height-home.height
        TabButton{
            id:home
            text:qsTr("关卡")
            width:tabBar.width/4
            height: window.height/10
            Image {
                focus: true
                id: homeiamge
                anchors.fill: parent
                source: tabBar.currentIndex !== 0?"../assets/img/homebutton1.png":"../assets/img/homebutton2.png"
            }
        }
        TabButton{
            focus: true
            text:qsTr("商店")
            width:tabBar.width/4
            height: window.height/10
            Image {
                id: storeiamge
                anchors.fill: parent
                source:tabBar.currentIndex !== 1?"../assets/img/storebutton1.png":"../assets/img/storebutton2.png"
            }
        }
        TabButton{

            ColorAnimation {
                from: "blue"
                to: "lightblue"
                duration: 200
            }
            focus: true
            text:qsTr("活动")
            width: tabBar.width/4
            height: window.height/10
            Image {
                id: acitivityiamge
                source: tabBar.currentIndex !== 2?"../assets/img/activitybutton1.png":"../assets/img/activitybutton2.png"
                anchors.fill: parent
            }
        }
        TabButton{
            focus: true
            text:qsTr("设置")
            width:tabBar.width/4
            height: window.height/10
            Image {
                id: settingiamge
                source: tabBar.currentIndex !== 3?"../assets/img/settingbutton1.png":"../assets/img/settingbutton2.png"
                anchors.fill: parent
            }
        }
    }

    //选择关卡场景
    SelectLevelScene {
        id: selectLevelScene
        //选择关卡信号槽
        onLevelPressed: {
            gameScene.setLevel(selectedLevel)

            window.state = "game"           //关卡被确定选择后进入游戏状态
        }
        onBackButtonPressed: window.state = "menu"      //选择关卡状态时按下返回将状态设置为菜单状态
    }


    property alias gameScene: gameScene
    //一关的游戏场景
    GameScene {
        id: gameScene
        onBackButtonPressed: window.state = "selectLevel"       //游戏状态时按下返回将状态设置为选择关卡状态
        onStateChanged: {
            GameData.diamondData = homediamond.loadDiamond()
        }
    }

    //开始场景
    StartScene{
        id:startScene

        onStartGameclicked: {
            window.state = "menu"       //开始状态时触摸进入菜单状态
        }
    }

    //加载场景
    LoadScene{
        id:loadScene
        Timer{
            running: true
            id:loadTimeOver
            interval: 7000
            onTriggered: {
                window.state = "start"          //加载时间完成进入开始状态
            }
        }
    }

    //设置第一个场景，开始为游戏加载场景
    state: "load"
    activeScene: loadScene

    //状态机 转换状态的时候切换场景，改变opacity
    states: [
        State {                 //加载状态
            name: "load"
            PropertyChanges {target: loadScene; opacity: 1}
            PropertyChanges {target: window; activeScene: loadScene}
        },
        State {
            name: "start"       //开始状态
            PropertyChanges {target: startScene; opacity: 1}
            PropertyChanges {target: window; activeScene: startScene}
        },
        State {                 //菜单状态
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: window; activeScene: menuScene}
        },
        State {                 //选择关卡状态
            name: "selectLevel"
            PropertyChanges {target: selectLevelScene; opacity: 1}
            PropertyChanges {target: window; activeScene: selectLevelScene}
        },
        State {                 //游戏状态
            name: "game"
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: window; activeScene: gameScene}
        }
    ]
}
