cmake_minimum_required(VERSION 3.16)

project(VMI_UI VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appVMI_UI
    main.cpp
)

qt_add_qml_module(appVMI_UI
    URI VMI_UI
    VERSION 1.0
    QML_FILES
        ui/Main.qml
        QML_FILES ui/screens/Menu.qml
        QML_FILES ui/screens/Aquisition.qml
        QML_FILES ui/screens/WelcomeScreen.qml
        QML_FILES ui/components/MenuButton.qml
        QML_FILES ui/components/Voltar.qml

    RESOURCES
        ./assets/storage.svg
        ./assets/back.svg
        ./assets/aquisition.svg
        ./assets/config.svg
        ./assets/vmi.png
        ./assets/labmov.png
        ./assets/logo.png
        ./assets/logo2.png
        QML_FILES ui/screens/Graph.qml
        QML_FILES ui/screens/Storage.qml
        QML_FILES ui/screens/Settings.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appVMI_UI PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appVMI_UI
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
