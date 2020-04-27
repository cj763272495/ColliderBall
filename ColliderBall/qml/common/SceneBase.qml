import Felgo 3.0
import QtQuick 2.0
import"../common"

Scene {
    id: sceneBase

    // 设置默认opocity为0
    opacity: 0
    // opacity大于0设为可见
    visible: opacity > 0

    // 禁用不可见场景（不可点击等）
    enabled: visible

    // opacity的改变被设置为动画
    Behavior on opacity {
        NumberAnimation {
            property: "opacity";
            easing.type: Easing.InOutQuad
        }
    }
}
