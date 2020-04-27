#include "qmllanguage.h"

//参数构造函数
QmlLanguage::QmlLanguage(QGuiApplication &app, QQmlApplicationEngine& engine)
{
    m_app = &app;
    m_engine = &engine;
}

void QmlLanguage::setLanguage(int nLanguage)
{
    QTranslator translator;
    if (nLanguage == 0)
    {
        //调用生成的文件 汉译英
        translator.load(":/tr_hz.qm");
    }else{
         translator.load(":/tr_en.qm");

        //调用生成的文件 英译汉

    }
    //加载
    m_app->installTranslator(&translator);
    //翻译
    m_engine->retranslate();
}
