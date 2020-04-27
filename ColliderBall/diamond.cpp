#include "diamond.h"

#include <QJsonDocument>

Diamond::Diamond(QObject *parent) : QObject(parent),
    m_diamond(0)
  ,m_isBuy(false)
{

}

Diamond::Diamond(int diamond, bool isBuy):

    m_diamond(diamond) ,
    m_isBuy(isBuy)
{

}

int Diamond::diamond() const
{
    return  m_diamond ;
}

void Diamond::setDiamond( int diamond)
{
    m_diamond = diamond;
    qDebug()<<"set diamond";
}

bool Diamond::isBuy() const
{
    return m_isBuy;
}

void Diamond::setIsBuy(bool isBuy)
{
    m_isBuy = isBuy;
}

int Diamond::loadDiamond()
{
    QFile loadFile("diamond.json");

    if(!loadFile.open(QIODevice::ReadOnly)){
        qWarning("couldn't open save file.");
        return false;
    }
    QByteArray saveData = loadFile.readAll();
    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));

    read(loadDoc.object());

    qDebug() << "loadDiamond file successfully";
    return m_diamond;
}

bool Diamond::saveDiamond( ) const
{
    QFile saveFile(QStringLiteral("diamond.json"));

    if (!saveFile.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QJsonObject gameObject;
    write(gameObject);
    QJsonDocument saveDoc(gameObject);
    saveFile.write(saveDoc.toJson());

    qDebug() << "save file successfully";
    return true;
}

bool Diamond::loadIsBuy()
{
    QFile loadFile("diamond.json");

    if(!loadFile.open(QIODevice::ReadOnly)){
        qWarning("couldn't open save file.");
        return false;
    }
    QByteArray saveData = loadFile.readAll();
    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));

    read(loadDoc.object());

    qDebug() << "loadIsBuy file successfully";
    return m_isBuy;
}

bool Diamond::saveIsBuy() const
{
    QFile saveFile(QStringLiteral("diamond.json"));

    if (!saveFile.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QJsonObject gameObject;
    write(gameObject);
    QJsonDocument saveDoc(gameObject);
    saveFile.write(saveDoc.toJson());

    qDebug() << "save file successfully";
    return true;
}


void Diamond::read(const QJsonObject &json)
{
    if(json.contains("diamond") && json["diamond"].isDouble())
        m_diamond = json["diamond"].toInt();
    if(json.contains("isBuy") && json["isBuy"].isBool())
        m_isBuy = json["isBuy"].toBool();
}

void Diamond::write(QJsonObject &json) const
{
    json["diamond"] = m_diamond;
    json["isBuy"] = m_isBuy;
}

