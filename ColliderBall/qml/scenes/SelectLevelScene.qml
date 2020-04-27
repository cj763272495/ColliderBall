import Felgo 3.0
import QtQuick 2.0
import "../common"
import ".."
import"../control"
import "../entities"
import"../scenes"

//选择关卡场景
SceneBase {
    id: selectLevelScene
    opacity: 0

    // 一个关卡已经被选择的信号
    signal levelPressed(string selectedLevel)
    signal loadData()

    property int num

    // 背景
    Item {
        anchors.fill: parent.gameWindowAnchorItem
        BackgroundImage{
            z:-2
            anchors.fill: parent
            id:selectlevebackgroudimage
            source: "../../assets/img/selectlevepage.png"
        }

        // 选择关卡
        Grid {
            anchors.centerIn: parent
            spacing: 10
            columns: 5
            MenuButton {
                z:-1
                text: "1"
                width: 50
                height: 50
                Image {
                    id: first
                    source: "../../assets/img/level1.png"
                    anchors.fill: parent
                }
                onClicked: {
                    levelPressed("Level1.qml")
                }
            }
            MenuButton {
                z:-1
                text: "2"
                width: 50
                height: 50
                Image {
                    id: second
                    anchors.fill:parent
                    source: "../../assets/img/level2.png"
                }
                onClicked: {
                    levelPressed("Level2.qml")
                }
            }
            MenuButton {
                z:-1
                text: "2"
                width: 50
                height: 50
                Image {
                    anchors.fill: parent
                    id: third
                    source: "../../assets/img/level3.png"
                }
                onClicked: {
                    levelPressed("Level3.qml")
                }
            }
            MenuButton {
                z:-1
                text: "2"
                width: 50
                height: 50
                Image {
                    anchors.fill: parent
                    id: four
                    source: "../../assets/img/level4.png"
                }
                onClicked: {
                    levelPressed("Level4.qml")
                }
            }
        }
    }

    // 返回按钮
    MenuButton {
        text: qsTr("Back")

        Image {
            id: returnbutton
            source: "../../assets/img/returnbutton.png"
            anchors.fill: parent
        }
        anchors.right: selectLevelScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: selectLevelScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: {
            num = window.outdiamond.loadDiamond()
            page2.txt = page1.txt = num

            console.log("return: " + window.outdiamond.diamond)
            backButtonPressed()
        }
    }

}
