import Felgo 3.0
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2 as QQD
import"../common"
import ".."
import"../control"
import "../entities"
import"../scenes"

//活动页
SceneBase{
    id:activitypage
    opacity: 1
    BackgroundImage {
        anchors.fill:parent
        //        scale: 0.5
        //        z:-2
        id: activitybackgroundimage
        source: "../../assets/img/acitivitypage.png"
    }
    ListView{
        id:modellisview
        z:2
        anchors.top: parent.top
        anchors.topMargin: parent.height/3
        anchors.left: parent.left
        anchors.leftMargin: parent.width/2-width/2
        width: parent.width/2
        height: parent.height/3
        //            orientation控制是水平还是竖直的 Qt.Horizontal表示为水平的  Qt.Vertical表示为竖直的 默认为竖直的
        orientation: Qt.Horizontal
        //            设置这些属性中的任何一个都将平滑地滚动ListView，以便当前项变为可见
        highlightFollowsCurrentItem:true
        //当移动图片时，使currentIndex也发生变化
        highlightRangeMode: ListView.StrictlyEnforceRange

        model: ActivityModel{}
        delegate: activitydelegete
        Component{
            id:activitydelegete
            Item{
                id:acitivityitem
                width: modellisview.width
                height: modellisview.height
                opacity: ListView.isCurrentItem?  1 : 0.5
                Text {
                    color: "white"
                    id: acitivitytext
                    text: titile
                    font.pixelSize: 30
                    anchors.bottom: activityimage.top
                    anchors.bottomMargin: 0
                }
                Image {
                    id: activityimage
                    scale: acitivityitem.ListView.isCurrentItem? 0.8:0.7
                    source:portrait
                    anchors.fill: parent
                }
            }
        }
    }

    MenuButton{
        width: parent.width/3
        height: parent.height/12
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: parent.height/1.4
        anchors.leftMargin: parent.width/2-width/2
        onClicked: {
            activitydialog.open()
        }
        Image {
            anchors.fill: parent
            source: "../../assets/img/homebuttonclicked.jpg"
        }
    }
    QQD.Dialog{
        id:activitydialog
//        height:activitypage.height
//        width: activitypage.width

        contentItem: Rectangle{
            implicitHeight: activitypage.height
            implicitWidth: activitypage.width
            Text {
                z:10
                id: dialogtext
                text:qsTr("敬请期待")
                color: "white"
                font.pixelSize: 40
                anchors.centerIn: parent
            }
            Image {
                id: dialogimage
                source: "../../assets/img/selectlevepage.png"
                anchors.fill: parent
            }
            Image {
                id: returnbutton
                source: "../../assets/img/returnbutton.png"
                width: parent.width/4
                height: parent.height/10
                anchors.top:parent.top
                anchors.topMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 0
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        activitydialog.close()
                    }
                }
            }
        }
    }
}
