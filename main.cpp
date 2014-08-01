#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickItem>

#include "camerasource.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // Register our CameraSource so our QML code can use it
    qmlRegisterType<CameraSource>("CameraSource", 1, 0, "CameraSource");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
