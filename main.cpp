#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QFont>

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    int fontId = QFontDatabase::addApplicationFont(":/fonts/Roboto.ttf");
    if (fontId != -1) {
        // Fetch the loaded font family name
        QString fontFamily = QFontDatabase::applicationFontFamilies(fontId).at(0);

        // Set it globally
        app.setFont(QFont(fontFamily, 12));
    }
    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("VMI_UI", "Main");

    return app.exec();
}
