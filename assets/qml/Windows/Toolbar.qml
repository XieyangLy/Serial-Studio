/*
 * Copyright (c) 2020-2021 Alex Spataru <https://github.com/alex-spataru>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import Qt.labs.settings 1.0

Control {
    id: root

    //
    // Dummy string to increase width of buttons
    //
    readonly property string _btSpacer: "  "

    //
    // Custom signals
    //
    signal dataClicked()
    signal aboutClicked()
    signal devicesClicked()
    signal consoleClicked()
    signal widgetsClicked()

    //
    // Aliases to button check status
    //
    property alias dataChecked: dataBt.checked
    property alias aboutChecked: aboutBt.checked
    property alias consoleChecked: consoleBt.checked
    property alias widgetsChecked: widgetsBt.checked
    property alias devicesChecked: devicesBt.checked

    //
    // Settings
    //
    Settings {
        property alias dataExport: csvLogging.checked
    }

    //
    // Background gradient
    //
    Rectangle {
        border.width: 1
        color: Qt.rgba(33/255, 55/255, 63/255, 1)
        border.color: Qt.darker(color)

        anchors {
            fill: parent
            topMargin: -border.width
            leftMargin: -border.width * 10
            rightMargin: -border.width * 10
        }
    }

    //
    // Toolbar icons
    //
    RowLayout {
        spacing: app.spacing
        anchors.fill: parent
        anchors.margins: app.spacing

        Button {
            id: devicesBt

            flat: true
            icon.width: 24
            icon.height: 24
            Layout.fillHeight: true
            icon.color: palette.text
            onClicked: root.devicesClicked()
            icon.source: "qrc:/icons/usb.svg"
            text: qsTr("Devices") + _btSpacer + CppTranslator.dummy
        }

        Button {
            id: consoleBt

            flat: true
            icon.width: 24
            icon.height: 24
            Layout.fillHeight: true
            icon.color: palette.text
            onClicked: root.consoleClicked()
            icon.source: "qrc:/icons/code.svg"
            enabled: dataBt.enabled || widgetsBt.enabled
            text: qsTr("Console") + _btSpacer + CppTranslator.dummy
        }

        Button {
            id: dataBt

            flat: true
            icon.width: 24
            icon.height: 24
            Layout.fillHeight: true
            icon.color: palette.text
            onClicked: root.dataClicked()
            enabled: CppDataProvider.groupCount > 0
            icon.source: "qrc:/icons/equalizer.svg"
            text: qsTr("Dashboard") + _btSpacer + CppTranslator.dummy

            opacity: enabled ? 1 : 0.5
            Behavior on opacity {NumberAnimation{}}
        }

        Button {
            id: widgetsBt

            flat: true
            icon.width: 24
            icon.height: 24
            Layout.fillHeight: true
            icon.color: palette.text
            onClicked: root.widgetsClicked()
            icon.source: "qrc:/icons/chart.svg"
            enabled: CppWidgets.totalWidgetCount > 0
            text: qsTr("Widgets") + _btSpacer + CppTranslator.dummy

            opacity: enabled ? 1 : 0.5
            Behavior on opacity {NumberAnimation{}}
        }

        Button {
            id: aboutBt

            flat: true
            icon.width: 24
            icon.height: 24
            Layout.fillHeight: true
            icon.color: palette.text
            onClicked: root.aboutClicked()
            icon.source: "qrc:/icons/info.svg"
            text: qsTr("About") + CppTranslator.dummy
        }

        Item {
            Layout.fillWidth: true
        }

        Switch {
            id: csvLogging
            checked: true
            Layout.alignment: Qt.AlignVCenter
            text: qsTr("CSV Export") + CppTranslator.dummy
            onCheckedChanged: CppExport.exportEnabled = checked
            palette.highlight: Qt.rgba(46/255, 137/255, 92/255, 1)
        }

        Button {
            flat: true
            icon.width: 24
            icon.height: 24
            Layout.fillHeight: true
            icon.color: palette.text
            icon.source: "qrc:/icons/bug.svg"
            onClicked: CppExport.openLogFile()
            text: qsTr("Log") + _btSpacer + CppTranslator.dummy

            Behavior on opacity {NumberAnimation{}}
        }

        Button {
            flat: true
            icon.width: 24
            icon.height: 24
            Layout.fillHeight: true
            icon.color: palette.text
            opacity: enabled ? 1 : 0.5
            onClicked: CppCsvPlayer.openFile()
            icon.source: "qrc:/icons/update.svg"
            text: qsTr("CSV Player") + _btSpacer + CppTranslator.dummy

            Behavior on opacity {NumberAnimation{}}
        }

        Button {
            flat: true
            icon.width: 24
            icon.height: 24
            Layout.fillHeight: true
            icon.color: palette.text
            enabled: CppExport.isOpen
            opacity: enabled ? 1 : 0.5
            icon.source: "qrc:/icons/open.svg"
            onClicked: CppExport.openCurrentCsv()
            text: qsTr("Open CSV") + _btSpacer + CppTranslator.dummy

            Behavior on opacity {NumberAnimation{}}
        }
    }
}
