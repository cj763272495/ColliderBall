import QtQuick 2.0
import"../common"
import ".."
import"../control"
import "../entities"
import"../scenes"
import QtMultimedia 5.9

//自定义菜单按钮
Rectangle {
    id: button
    // 默认按钮大小 = 文本大小 + 边距大小
    width: buttonText.width+ paddingHorizontal*2
    height: buttonText.height+ paddingVertical*2

    //设置自定义菜单按钮颜色
    color: "#e9e9e9"
    border.color: "#333"

    radius: 10

    // 文本到矩形的水平边距
    property int paddingHorizontal: 10

    // 文本和矩形的垂直边距
    property int paddingVertical: 5

    // 访问文本组件的文本
    property alias text: buttonText.text

    //访问文本颜色
    property alias txtcolor: buttonText.color

    // 点击信号
    signal clicked

    //文本设置
    Text {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: 18
        color: "white"
    }

    //鼠标点击区域
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true      //鼠标悬停，悬停允许处理所有鼠标事件，即使没有按下鼠标按钮。

        visible: parent.opacity > 0
        enabled: visible

        onClicked: {
            parent.scale = 1.0
            parent.clicked()
        }
        onPressed: {
            parent.scale = 0.85
            button.opacity = 0.5
            sound.play()
            console.log("mouse click")
        }

        onReleased: {
            parent.scale = 1.0
            button.opacity = 1
        }
        onCanceled: {
            parent.scale = 1.0
        }

        //按钮点击音效
        MediaPlayer{
            id:sound
            //playing: false
            volume: 1
            source: "../../assets/sond/button.wav"
        }
    }
}
