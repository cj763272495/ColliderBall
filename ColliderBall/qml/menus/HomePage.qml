import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.3

import"../common"
import ".."
import"../control"
import "../entities"
import"../scenes"
import DiaData 1.0

//主页
Scene{
    id:homepage

    opacity: 1
    enabled: opacity
    property alias txt: diaNum.text

    signal selectLevelPressed       //选择关卡按钮被按下信号

    //设置背景图片
    BackgroundImage {
        anchors.fill: parent
        id: homebackgroundimage
        source: "../../assets/img/homepage.png"
    }

    //选择关卡按钮
    MenuButton{
        id:select
        width: parent.width/3
        height: parent.height/12
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: parent.height/1.4
        anchors.leftMargin: parent.width/2-width/2
        text: qsTr("选择关卡")

        onClicked:
        {
            selectLevelPressed()
        }

        Image {
            anchors.fill: parent
            source: "../../assets/img/homebuttonclicked.jpg"
        }
    }

    //返回按钮
    MenuButton {
        z:2
        text: qsTr("Back")
        width: parent.width/8
        height: parent.height/16
        txtcolor: "white"
        color: "#36648B"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 20
        onClicked: backButtonPressed()
    }

    //新的游戏按钮
    MenuButton{
        id:createId
        text: qsTr("New Game")
        anchors.bottom: select.top
        anchors.bottomMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        height: 40
        width: 100
        color: "#104E8B"
        Image {
            z:-1
            id: bg
            source: "../../assets/img/backbutton.png"
            anchors.fill: parent
        }

        onClicked: {
            newPlayer.opacity = 0.85
            createId.opacity = 0
            select.opacity = 0
            console.log(window.outdiamond.diamond)
            diaNum.text = window.outdiamond.loadDiamond()
        }
    }

    //左上角宝石数量
    Rectangle{
        width: 65
        height: 30
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        color: "#104E8B"
        opacity: 0.7

        Image {
            id: diamondImg
            anchors.left: parent.left
            width: 30
            height: 30
            source: "../../assets/img/ball4.png"
        }

        Text {
            id: diaNum
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 1

            text: window.outdiamond.loadDiamond()
            font.pixelSize: 20
            color: "white"
        }
    }

    //新的角色
    Rectangle{
        width: 240
        height: 150

        radius: 15
        anchors.centerIn: parent

        color: "#EE2C2C"
        opacity: 0
        id:newPlayer
        enabled: opacity > 0

        //创建新用户Dialog
        Text {
            id: dialogtxt
            font.pixelSize: 20
            text: qsTr("创建新玩家")
            color: "white"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextInput{
            activeFocusOnPress: true
            autoScroll: true
            font.pixelSize: 20
            text: qsTr("enter yur name")
            color: "white"

            cursorVisible: true
            id:playerName
            anchors.top: dialogtxt.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
        }

        MenuButton {
            id: confirmButton
            text: qsTr("确认")
            height: 40
            width: 40
            anchors.top: playerName.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                newPlayer.opacity = 0
                createId.opacity = 1
                select.opacity = 1
            }
        }
    }
}
