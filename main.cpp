#include <QPixmap>
#include <QApplication>
#include <QtQuick/QQuickItem>
#include <QQmlApplicationEngine>

#include "settings.h"
#include "camerasource.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // Register our CameraSource so our QML code can use it
    qmlRegisterType<CameraSource>("CameraSource", 1, 0, "CameraSource");
    qmlRegisterType<Settings>("Settings", 1, 0, "Settings");

    QPixmap emptyCursor(16, 16);
    emptyCursor.fill(Qt::transparent);
//    app.setOverrideCursor(QCursor(emptyCursor));

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
