cmake_minimum_required(VERSION 3.16)

project(VMI_UI VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appVMI_UI
    main.cpp
    filemanager.h
    filemanager.cpp
)

qt_add_qml_module(appVMI_UI
    URI VMI_UI
    VERSION 1.0
    QML_FILES
        ui/Main.qml
        ui/screens/Menu.qml
        ui/screens/Aquisition.qml
        ui/screens/WelcomeScreen.qml
        ui/screens/Graph.qml
        ui/screens/Storage.qml
        ui/screens/Settings.qml
        ui/components/MenuButton.qml
        ui/components/Voltar.qml
        ui/components/FAContainer.qml
    RESOURCES
        ./assets/storage.svg
        ./assets/back.svg
        ./assets/aquisition.svg
        ./assets/config.svg
        ./assets/vmi.png
        ./assets/labmov.png
        ./assets/logo.png
        ./assets/logo2.png
        ./assets/rainbow.png
        ./assets/umbrella.png
        ./assets/logonome.png
        ./assets/logosemnome.png
        SOURCES filemanager.h filemanager.cpp
        QML_FILES ui/components/LogoAnimada.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
set_target_properties(appVMI_UI PROPERTIES
#   MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appVMI_UI
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appVMI_UI
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appVMI_UI
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
