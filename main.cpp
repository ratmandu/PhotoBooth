#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickItem>
#include <QPixmap>
#include "camerasource.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // Register our CameraSource so our QML code can use it
    qmlRegisterType<CameraSource>("CameraSource", 1, 0, "CameraSource");

    QPixmap emptyCursor(16, 16);
    emptyCursor.fill(Qt::transparent);
//    app.setOverrideCursor(QCursor(emptyCursor));

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
