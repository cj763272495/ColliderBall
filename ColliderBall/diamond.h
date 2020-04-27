#ifndef PLAYER_H
#define PLAYER_H

#include <QObject>
#include <QJsonObject>
#include <QObject>
#include <QString>
#include "QDebug"
#include <QFile>


class Diamond : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int diamond READ diamond WRITE setDiamond NOTIFY  diamondChanged)
    Q_PROPERTY(int isBuy READ isBuy WRITE setIsBuy  NOTIFY isBuyChanged)
public:
    explicit Diamond(QObject *parent = nullptr);
    Diamond( int diamond, bool isBuy);

    int diamond() const;
    void setDiamond(int diamond );

    bool isBuy() const;
    void setIsBuy(bool isBuy );

    Q_INVOKABLE bool loadIsBuy();
    Q_INVOKABLE bool saveIsBuy( ) const;

    Q_INVOKABLE int loadDiamond();
    Q_INVOKABLE bool saveDiamond( ) const;


    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
signals:
    void diamondChanged();
    void isBuyChanged();

private:
    int m_diamond;
    bool m_isBuy;
};

#endif // PLAYER_H
