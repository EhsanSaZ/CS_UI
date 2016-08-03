TEMPLATE = app

TARGET = CS

QT += qml quick widgets

CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/quickcontrols/controls/filesystembrowser
INSTALLS += target

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
