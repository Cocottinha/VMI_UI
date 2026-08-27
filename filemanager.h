#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <QObject>
#include <QDir>
#include <QFile>
#include <QTextStream>
#include <QStringList>
#include <QVariant>
#include <QFileInfo>
#include <QDateTime>

class FileManager : public QObject
{
    Q_OBJECT

public:
    explicit FileManager(QObject *parent = nullptr);

    Q_INVOKABLE bool createFolder(const QString &path);
    Q_INVOKABLE bool saveToFile(const QString &filePath, const QString &content);

    // File methods
    Q_INVOKABLE QStringList getFilesInFolder(const QString &folderPath);
    Q_INVOKABLE QStringList getFilesInFolderWithFilter(const QString &folderPath, const QStringList &filters);
    Q_INVOKABLE QString getFileInfo(const QString &filePath);
    Q_INVOKABLE qint64 getFileSize(const QString &filePath);
    Q_INVOKABLE QDateTime getFileCreatedTime(const QString &filePath);
    Q_INVOKABLE QString getFileNameFromPath(const QString &filePath);

    // Folder methods
    Q_INVOKABLE QStringList getFoldersInFolder(const QString &folderPath);
    Q_INVOKABLE QStringList getAllItemsInFolder(const QString &folderPath);
    Q_INVOKABLE QStringList getAllItemsInFolderWithFilter(const QString &folderPath, const QStringList &filters);
    Q_INVOKABLE QString getFolderInfo(const QString &folderPath);
    Q_INVOKABLE bool folderExists(const QString &folderPath);
    Q_INVOKABLE qint64 getFolderSize(const QString &folderPath);
    Q_INVOKABLE int getItemCountInFolder(const QString &folderPath);

private:
    QDir m_dir;
    qint64 calculateFolderSize(const QString &folderPath);
};

#endif // FILEMANAGER_H
