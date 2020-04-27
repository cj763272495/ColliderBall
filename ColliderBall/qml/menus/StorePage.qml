import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.3
import "../scenes"
import"../common"
import ".."
import"../control"
import "../entities"
import QtMultimedia 5.9


//商店页面
SceneBase{
    opacity: 1
    id:storepage

    //背景图片
    BackgroundImage {
        anchors.fill: parent
        //            scale: 0.5
        //            z:-2
        id: storebackgrounsimage
        source: "../../assets/img/storepage.png"
    }

    ListView{
        //            visible: false
        id:balllistview
        z:2
        x: storepage.width/2-width/2
        y: storepage.height/2+height/2
        width: parent.width/3.5
        height: parent.height/8
        //            highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        //            focus: true
        //            orientation控制是水平还是竖直的 Qt.Horizontal表示为水平的  Qt.Vertical表示为竖直的 默认为竖直的
        orientation: Qt.Horizontal
        //             flickableDirection:  Flickable.AutoFlickIfNeeded
        //            设置这些属性中的任何一个都将平滑地滚动ListView，以便当前项变为可见
        highlightFollowsCurrentItem:true
        //            currentIndex属性保存当前项的索引，currentItem保存当前项
        //            currentIndex: 0
        //当移动图片时，使currentIndex也发生变化
        highlightRangeMode: ListView.StrictlyEnforceRange
        //            flickableDirection:Flickable.horizontalCenter

        snapMode: ListView.SnapOneItem
        //            layoutDirection: Qt.LeftToRight
        model: BallcolorModel{}
        delegate: contactDelegate
        Component{

            id:contactDelegate
            Item {
                id:ballItem
                width: balllistview.width
                height:balllistview.height
                opacity: ListView.isCurrentItem?  1 : 0.5
                //                Column{
                //                    x: storepage.width/2-width/2
                //                    y: storepage.height/2+height/2
                //                    width: parent.width/3.5
                //                    height: parent.height/8
                Text {
                    color: "white"
                    id:textball
                    //                    width:parent.width
                    //                    height: parent/3
                    //                    anchors.top: parent.top
                    //                    anchors.topMargin: 0

                    font.pixelSize: 30
                    text: balltext
                    opacity: ballItem.ListView.isCurrentItem?  1 :0
                    anchors.bottom: imageball.top
                    anchors.bottomMargin: 0

                }
                Image {
                    id:imageball
                    //                    width: balllistview.width
                    //                    height: balllistview/3*2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    //                    anchors.fill: parent
                    source: portrait
                    scale: ballItem.ListView.isCurrentItem? 0.6:0.4
                }
            }
        }
    }
    //                    }

    //购买按钮
    MenuButton {
        opacity:!window.outdiamond.isBuy
        enabled: opacity
        id: buyButton
        x: storepage.width/2-width/2
        y: parent.height/1.4
        width: parent.width/3
        height: parent.height/12

        Image {
            anchors.fill: parent
            id: storeimage
            source: "../../assets/img/storebutton1.jpg"
        }

        onClicked: {
            if(window.outdiamond.diamond >= GameData.colorprice){

                buyed.opacity = 1
                buyButton.opacity = 0
                useButton.opacity = 1
                var i = window.outdiamond.diamond = window.outdiamond.loadDiamond()- GameData.colorprice
                window.outdiamond.saveDiamond();

                console.log("余额" + i)
                diaNum.text = i
                page1.txt = i;

                //存档已经购买
                console.log("购买。。。")

                window.outdiamond.isBuy = true
                window.outdiamond.saveIsBuy()
                window.outdiamond.loadIsBuy()
                console.log("isbuy??? " + window.outdiamond.loadIsBuy())
            }
            else{
                noDiamond.opacity = 1
            }
        }
    }

    //应用颜色按钮
    MenuButton {
        opacity: window.outdiamond.isBuy
        enabled: opacity
        id: useButton
        x: storepage.width/2-width/2
        y: parent.height/1.4
        width: parent.width/3
        height: parent.height/12

        color: "#36648B"
        text: qsTr("应用")

        onClicked: {
            switch(balllistview.currentIndex){
            case 0:GameData.ballColor = "blue";console.log("blue  0"); break;
            case 1:GameData.ballColor = "green"; console.log("green  1"); break;
            case 2:GameData.ballColor = "red"; console.log("red  2"); break;
            case 3:GameData.ballColor = "yellow"; console.log("yellow 3"); break;
            }
        }

    }

    //余额不足
    Rectangle{
        id:noDiamond
        anchors.centerIn: parent
        opacity: 0
        enabled: opacity > 0
        color: "lightsteelblue"
        width: 200
        height: 150
        radius: 15

        Text {
            id: noDiamondTxt
            text: qsTr("you can't buy")
            font.pixelSize: 25
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }

        MenuButton{
            id:noDiamondDialog
            text: qsTr("确定")

            anchors.top: noDiamondTxt.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                parent.opacity = 0
            }
        }
    }

    //购买成功
    Rectangle{
        id:buyed
        anchors.centerIn: parent
        opacity: 0
        enabled: opacity > 0
        color: "lightsteelblue"
        width: 200
        height: 150
        radius: 15

        Text {
            id: buyTxt
            text: qsTr("购买成功")
            font.pixelSize: 25
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }

        MenuButton{
            id:buyedButton
            text: qsTr("确定")

            anchors.top: buyTxt.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                parent.opacity = 0
            }
        }
    }

    //商店界面音效
    BackgroundMusic{
        id:storeMusic
        autoPlay: false
        loops: SoundEffect.Infinite
        autoPauseInBackground:true
        source: "../../assets/sond/StoreScene.mp3"
    }


    property alias txt: diaNum.text

    //----------------------------左上角宝石数量---------------------------
    Rectangle{
        width: 65
        height: 30
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        color: "#104E8B"
        opacity: 0.8

        Image {
            id: diamondImg
            anchors.left: parent.left
            width: 30
            height: 30
            source: "../../assets/img/diamond.jpg"
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
}
