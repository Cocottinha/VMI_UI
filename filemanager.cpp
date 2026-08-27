#include "filemanager.h"
#include <QDebug>

FileManager::FileManager(QObject *parent) : QObject(parent) {}

bool FileManager::createFolder(const QString &path)
{
    QDir dir(path);
    return dir.mkpath(".");
}

bool FileManager::saveToFile(const QString &filePath, const QString &content)
{
    QFile file(filePath);
    if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream out(&file);
        out << content;
        file.close();
        return true;
    }
    return false;
}

QStringList FileManager::getFilesInFolder(const QString &folderPath)
{
    QDir dir(folderPath);

    if (!dir.exists()) {
        qWarning() << "Diretório inexistente:" << folderPath;
        return QStringList();
    }

    QStringList files = dir.entryList(QDir::Files | QDir::NoDotAndDotDot, QDir::Name);

    QStringList fullPaths;
    for (const QString &file : files) {
        fullPaths.append(dir.absoluteFilePath(file));
    }

    return fullPaths;
}

QStringList FileManager::getFilesInFolderWithFilter(const QString &folderPath, const QStringList &filters)
{
    QDir dir(folderPath);

    if (!dir.exists()) {
        qWarning() << "Diretório inexistente:" << folderPath;
        return QStringList();
    }

    QStringList files = dir.entryList(filters, QDir::Files | QDir::NoDotAndDotDot, QDir::Name);

    QStringList fullPaths;
    for (const QString &file : files) {
        fullPaths.append(dir.absoluteFilePath(file));
    }

    return fullPaths;
}

QString FileManager::getFileInfo(const QString &filePath)
{
    QFileInfo fileInfo(filePath);

    if (!fileInfo.exists()) {
        return "Arquivo inexistente:";
    }

    return QString("Name: %1\nSize: %2 bytes\nCreated: %3")
        .arg(fileInfo.fileName())
        .arg(fileInfo.size())
        .arg(fileInfo.birthTime().toString("yyyy-MM-dd hh:mm:ss"));
}

qint64 FileManager::getFileSize(const QString &filePath)
{
    QFileInfo fileInfo(filePath);
    return fileInfo.exists() ? fileInfo.size() : -1;
}

QDateTime FileManager::getFileCreatedTime(const QString &filePath)
{
    QFileInfo fileInfo(filePath);
    return fileInfo.exists() ? fileInfo.birthTime() : QDateTime();
}

QString FileManager::getFileNameFromPath(const QString &filePath)
{
    QFileInfo fileInfo(filePath);
    return fileInfo.fileName();
}

// ============ FOLDER METHODS ============

QStringList FileManager::getFoldersInFolder(const QString &folderPath)
{
    QDir dir(folderPath);

    if (!dir.exists()) {
        qWarning() << "Diretório inexistente:" << folderPath;
        return QStringList();
    }

    // Get all directories (excluding files and . & ..)
    QStringList folders = dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot, QDir::Name);

    QStringList fullPaths;
    for (const QString &folder : folders) {
        fullPaths.append(dir.absoluteFilePath(folder));
    }

    return fullPaths;
}

QStringList FileManager::getAllItemsInFolder(const QString &folderPath)
{
    QDir dir(folderPath);

    if (!dir.exists()) {
        qWarning() << "Diretório inexistente:" << folderPath;
        return QStringList();
    }

    // Get both files and directories
    QStringList items = dir.entryList(QDir::AllEntries | QDir::NoDotAndDotDot, QDir::Name);

    QStringList fullPaths;
    for (const QString &item : items) {
        fullPaths.append(dir.absoluteFilePath(item));
    }

    return fullPaths;
}

QStringList FileManager::getAllItemsInFolderWithFilter(const QString &folderPath, const QStringList &filters)
{
    QDir dir(folderPath);

    if (!dir.exists()) {
        qWarning() << "Diretório inexistente:" << folderPath;
        return QStringList();
    }

    // Get items with filters (applies to files only)
    QStringList items = dir.entryList(filters, QDir::AllEntries | QDir::NoDotAndDotDot, QDir::Name);

    QStringList fullPaths;
    for (const QString &item : items) {
        fullPaths.append(dir.absoluteFilePath(item));
    }

    return fullPaths;
}

QString FileManager::getFolderInfo(const QString &folderPath)
{
    QFileInfo folderInfo(folderPath);

    if (!folderInfo.exists() || !folderInfo.isDir()) {
        return "Folder does not exist";
    }

    QDir dir(folderPath);
    int fileCount = dir.entryList(QDir::Files | QDir::NoDotAndDotDot).count();
    int folderCount = dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot).count();
    qint64 size = getFolderSize(folderPath);

    return QString("Name: %1\nItems: %2 files, %3 folders\nTotal Size: %4 bytes\nCreated: %5")
        .arg(folderInfo.fileName())
        .arg(fileCount)
        .arg(folderCount)
        .arg(size)
        .arg(folderInfo.birthTime().toString("yyyy-MM-dd hh:mm:ss"));
}

bool FileManager::folderExists(const QString &folderPath)
{
    QDir dir(folderPath);
    return dir.exists();
}

qint64 FileManager::getFolderSize(const QString &folderPath)
{
    return calculateFolderSize(folderPath);
}

int FileManager::getItemCountInFolder(const QString &folderPath)
{
    QDir dir(folderPath);

    if (!dir.exists()) {
        return -1;
    }

    int fileCount = dir.entryList(QDir::Files | QDir::NoDotAndDotDot).count();
    int folderCount = dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot).count();

    return fileCount + folderCount;
}

// Private recursive method to calculate folder size
qint64 FileManager::calculateFolderSize(const QString &folderPath)
{
    QDir dir(folderPath);
    qint64 totalSize = 0;

    // Calculate size of all files in current directory
    QFileInfoList files = dir.entryInfoList(QDir::Files);
    for (const QFileInfo &fileInfo : files) {
        totalSize += fileInfo.size();
    }

    // Recursively calculate size of all subdirectories
    QFileInfoList subDirs = dir.entryInfoList(QDir::Dirs | QDir::NoDotAndDotDot);
    for (const QFileInfo &subDirInfo : subDirs) {
        totalSize += calculateFolderSize(subDirInfo.absoluteFilePath());
    }

    return totalSize;
}
