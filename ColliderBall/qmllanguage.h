#ifndef QMLLANGUAGE_H
#define QMLLANGUAGE_H

#pragma once
#include <QObject>
#include <QTranslator>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

//定义QmlLanguage类，他继承自QObject
class QmlLanguage : public QObject
{
    Q_OBJECT
public:
    QmlLanguage(QGuiApplication& app, QQmlApplicationEngine &engine);

    Q_INVOKABLE void setLanguage(int nLanguage);

private:
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;
};

#endif // QMLLANGUAGE_H
