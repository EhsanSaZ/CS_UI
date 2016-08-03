import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick 2.2
import QtQuick.Controls 1.5
import QtQml.Models 2.2
//import io.qt.examples.quick.controls.filesystembrowser 1.0
import Qt.labs.settings 1.0
import QtQuick.Controls 1.5

import Qt.labs.settings 1.0

ApplicationWindow {
    visible: true
    id:window
    property var sc_w:Screen.desktopAvailableWidth
    property var sc_h: Screen.desktopAvailableHeight
    minimumHeight: Screen.desktopAvailableHeight*0.6
    minimumWidth: Screen.desktopAvailableWidth*0.6
    width: sc_w*0.9
    height: sc_h*0.9
    title: qsTr("File System")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open")
                shortcut:"Ctrl+O"
                onTriggered: console.log("Open action triggered");
                iconSource: "download.png"
            }

            MenuItem{
                text: qsTr("Add A New File")
                onTriggered: console.log("Save action triggered");
            }
            MenuSeparator { }

            MenuItem {
                text: qsTr("Close")
                shortcut: "Ctrl+W"
                onTriggered: console.log("close action triggered");
            }

            MenuSeparator { }

            MenuItem{
                text: qsTr("Save")
                shortcut: "Ctrl+S"
                onTriggered: console.log("Save action triggered");
            }
            MenuItem{
                text: qsTr("Save As")
                onTriggered: console.log("Save As action triggered");
            }
            MenuSeparator { }


            MenuItem {
                text: qsTr("Exit")
                shortcut: "Ctrl+E"
                onTriggered: Qt.quit();
            }
        }
        Menu{
            Button {
                text: "Button"
            }
            title:qsTr("Options")
            MenuItem{
                text: qsTr("Run")
                onTriggered: console.log("Run action triggered");
            }
            MenuItem{
                text: qsTr("Debug")
                onTriggered: console.log("Debug action triggered");
            }
        }

    }

    GridLayout {
        id : grid
        anchors.fill: parent
        rows    : 19
        columns : 16
        property double colMulti : grid.width / grid.columns
        property double rowMulti : grid.height / grid.rows
        function prefWidth(item){
            return colMulti * item.Layout.columnSpan
        }
        function prefHeight(item){
            return rowMulti * item.Layout.rowSpan
        }
        Rectangle {
            color : 'black'
            Layout.rowSpan   : 1
            Layout.columnSpan: 16
            Layout.preferredWidth  : grid.prefWidth(this)
            Layout.preferredHeight : grid.prefHeight(this)
        }

        Rectangle {

            color : 'red'
            Layout.rowSpan   : 12
            Layout.columnSpan: 3
            Layout.preferredWidth  : grid.prefWidth(this)
            Layout.preferredHeight : grid.prefHeight(this)

            visible: true

            ItemSelectionModel {
                id: sel
                model: fileSystemModel
            }
            TreeView {
                id: view
                anchors.fill: parent

                model: fileSystemModel
                rootIndex: rootPathIndex

                selection: sel

                TableViewColumn {
                    title: "Name"
                    role: "fileName" 
                }

                onActivated : {
                    var url = fileSystemModel.data(index, FileSystemModel.UrlStringRole)
                    Qt.openUrlExternally(url)
                }
            }
        }
        Rectangle {
            color : 'yellow'
            Layout.rowSpan   : 12
            Layout.columnSpan: 10
            Layout.preferredWidth  : grid.prefWidth(this)
            Layout.preferredHeight : grid.prefHeight(this)
        }
        Rectangle {

            color : 'green'
            Layout.rowSpan : 12
            Layout.columnSpan : 3
            Layout.preferredWidth  : grid.prefWidth(this)
            Layout.preferredHeight : grid.prefHeight(this)
        }
        Rectangle {

            color : 'orange'
            Layout.rowSpan : 6
            Layout.columnSpan : 3
            Layout.preferredWidth  : grid.prefWidth(this)
            Layout.preferredHeight : grid.prefHeight(this)
        }
        Rectangle {

            color : 'pink'
            Layout.rowSpan : 6
            Layout.columnSpan : 13
            Layout.preferredWidth  : grid.prefWidth(this)
            Layout.preferredHeight : grid.prefHeight(this)
        }
    }
}
