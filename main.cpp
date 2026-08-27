#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext> // <--- Necessário para usar o rootContext
#include <QFontDatabase>
#include <QFont>
#include "filemanager.h" // Cabeçalho da sua classe

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    // 1. Instancia o seu gerenciador de arquivos C++
    FileManager fileManager;

    int fontId = QFontDatabase::addApplicationFont(":/fonts/Roboto.ttf");
    if (fontId != -1) {
        QString fontFamily = QFontDatabase::applicationFontFamilies(fontId).at(0);
        app.setFont(QFont(fontFamily, 12));
    }

    QQmlApplicationEngine engine;

    // 2. Disponibiliza o objeto globalmente para o QML com o nome "fileManager"
    engine.rootContext()->setContextProperty("fileManager", &fileManager);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("VMI_UI", "Main");

    return app.exec();
}
