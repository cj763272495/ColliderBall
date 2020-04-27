import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.3
import QtMultimedia 5.0

import"../common"
import ".."
import"../control"
import "../entities"
import"../scenes"

//设置页面
SceneBase{
    opacity: 1
    id:settingpage
    signal settingsPressed
    BackgroundMusic{
        id:bgMusic
        source: "../../assets/sond/GameSceneBg.mp3"
        loops: SoundEffect.Infinite
        volume: 0.35
        autoPlay: false
        autoPauseInBackground:true
    }

    Timer {
        id: timerMusic
        interval: 5000; running: true; repeat: true;
        onTriggered: {
            bgMusic.play()
            running = false
        }
    }

    BackgroundImage {
        anchors.fill: parent
        ////        scale: 0.5
        ////        z: -2
        id: background
        source: "../../assets/img/settingpage.png"
    }

    Column{
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        //            anchors.horizontalCenter: parent.horizontalCenter

        width: parent.width *0.28
        height: parent.height*0.5
        //            anchors.horizontalCenterOffset: 0
        //            spacing: 20

        Text {
            id:settingtext
            height: parent.height/6
            //        if(checkState == "Qt.checked")
            x: 121
            font.pixelSize: 36
            text:qsTr("设置")
            color: "white"
        }
        Text {
            height: parent.height/6
            font.pixelSize: 24
            text: qsTr("声音")
            color: "white"
        }

        Text {
            height: parent.height/6
            font.pixelSize: 24
            text: qsTr("显示摇杆")
            color: "white"
        }
        Text {
            height: parent.height/6
            font.pixelSize: 24
            text: qsTr("语言")
            color: "white"
        }
        Text {
            height: parent.height/6
            font.pixelSize: 24
            text: qsTr("帮助")
            color: "white"
        }
        Text {
            height: parent.height/6
            x: 150
            font.pixelSize: 24
            text: "        V 0.8"
            color: "white"
        }
    }

    Column{
        x: 208
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 22
        width: parent.width*0.28
        height: parent.height*0.5
        anchors.topMargin: 75

        AppCheckBox {
            z:2
            id: sound
            height: parent.height/6
            width: 33
            //            height: 29
            //当点击按钮时，则设置settings.musicEnabled为true，则播放音乐
            //  此处千万不要设置settings.musicEnabled的值为false,他是和数据库交互的东西，要想重新设置为true,则用以下代码
            //            Component.onCompleted: {
            //            var tempNumberGameStarts = settings.setValue("musicEnabled",true)
            //            }
            checked: true
            onPressedChanged: {
                if(!checked)
                    bgMusic.pause()
                if(checked)
                    bgMusic.play()
            }
        }

        AppCheckBox {
            id: shouwRacker

            z:2
            height: parent.height/6
            width: 33

            checked: true
            onPressedChanged: {
                if(!checked)
                    Racker.opacity = 0
                if(checked)
                    Racker.opacity = 1
            }

        }
        ComboBox {
            opacity: 0.5
            width: parent.width/1.1
            height: parent.height/8
            z:2
            //            opacity: 0.5
            id: comboBox
            //            width: 104
            //            height: 33
            font.underline: false
            font.bold: true
            font.pixelSize: 12
            font.family: "Arial"
            //当前项
            currentIndex: 0
            focusPolicy: Qt.ClickFocus
            textRole: "key"

            model: ListModel {
                ListElement { key: "简体中文"}
                ListElement { key: "English" }
            }
            onCurrentIndexChanged: {
                if(currentIndex==1)
//                    console.log(1)
                    //调用main.cpp传过来的参数qmlLanguage，然后调用他的函数setLanguage
                    qmlLanguage.setLanguage(0);
//                if(currentIndex==0);
                if(currentIndex==0)
                    qmlLanguage.setLanguage(1)
            }
        }
    }
}
