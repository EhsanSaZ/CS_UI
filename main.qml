import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.5
import QtQml.Models 2.2
//import io.qt.examples.quick.controls.filesystembrowser 1.0
import Qt.labs.settings 1.0
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4
import Qt.labs.settings 1.0

ApplicationWindow {
    visible: true
    id:window
    property int sc_w:Screen.desktopAvailableWidth
    property int sc_h: Screen.desktopAvailableHeight
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
            id :treeview_menu

            Layout.rowSpan   : 12
            Layout.columnSpan: 3
            Layout.preferredWidth  : grid.prefWidth(this)
            Layout.preferredHeight : grid.prefHeight(this)

            visible: true
            TabView {
                anchors.fill: parent
                Tab {

                    title: "SYMBOLS"
                    Rectangle { color: "blue" }
                }
                Tab {
                    title: "FILEs"
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
                style: TabViewStyle {
                        frameOverlap: 1
                        tab: Rectangle {
                            color: styleData.selected ? "steelblue" :"lightsteelblue"
                            border.color:  "steelblue"
                            implicitWidth:treeview_menu.width/2
                            implicitHeight: text.height+3
                            radius: 2
                            Text {
                                id: text
                                anchors.centerIn: parent
                                text: styleData.title
                                color: styleData.selected ? "white" : "black"
                            }
                        }
                        frame: Rectangle { color: "steelblue" }
                    }
            }

        }


Rectangle {
    color : 'yellow'
    id: workplace
    Layout.rowSpan   : 12
    Layout.columnSpan: 10
    Layout.preferredWidth  : grid.prefWidth(this)
    Layout.preferredHeight : grid.prefHeight(this)
    Layout.maximumWidth:  grid.prefWidth(this)
    ScrollView{
        width:workplace.width
        height:workplace.height
            Flickable {
                id: flickArea
                anchors {fill: parent; }
                contentWidth: rect.width*rect.scale
                contentHeight: rect.height*rect.scale
                Rectangle {
                    id: rect
                    transformOrigin: Item.TopLeft
                    width: workplace.width*2
                    height: workplace.height*2
                    color: "lightgrey"
                    Rectangle {
                        id: inner
                        anchors { fill: parent; margins: 25; }
                        color: "red"
                        Text{
                            horizontalAlignment:Text.AlignRight
                            verticalAlignment:Text.AlignBottom
                            text:"BUTTOM-RIGHT"
                        }
                    }
                    MouseArea {
                        id: dragArea
                        hoverEnabled: true
                        anchors.fill:  parent
                        //drag.target: photoFrame
                        scrollGestureEnabled: false  // 2-finger-flick gesture should pass through to the Flickable
                        onWheel: {
                            var scale_after = rect.scale + rect.scale * wheel.angleDelta.y / 120 / 10;
                            if ( wheel.modifiers & Qt.ControlModifier ) {
                                if(scale_after >=1){
                                console.log(scale_after)
                                rect.scale += rect.scale * wheel.angleDelta.y / 120 / 10;
                                }
                            }
                        }
                    }
                }
            }
        }
/*
Button {
anchors.bottom: parent.bottom;
anchors.horizontalCenter: parent.horizontalCenter;
text: "Scale flickArea"
onClicked: {

if(rect.scale >= 1 ){
rect.scale -= 0.2;
}
}
}
Button {
anchors.bottom: parent.bottom;

text: "Scale flickArea"
onClicked: {

if(rect.scale >= 1 ){
rect.scale -= 0.2;
}

}
}*/
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
