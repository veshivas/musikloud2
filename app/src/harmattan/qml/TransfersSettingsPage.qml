/*
 * Copyright (C) 2015 Stuart Howarth <showarth@marxoft.co.uk>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 1.1
import com.nokia.meego 1.0
import MusiKloud 2.0
import "file:///usr/lib/qt4/imports/com/nokia/meego/UIConstants.js" as UI

MyPage {
    id: root

    title: qsTr("Transfers")
    tools: ToolBarLayout {

        BackToolIcon {}
    }

    Flickable {
        id: flicker

        anchors.fill: parent
        contentHeight: column.height + UI.PADDING_DOUBLE

        Column {
            id: column

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }
            
            PageHeader {
                title: root.title
            }

            ValueSelector {
                width: parent.width
                title: qsTr("Maximum concurrent transfers")
                model: ConcurrentTransfersModel {}
                value: Settings.maximumConcurrentTransfers
                onValueChanged: Settings.maximumConcurrentTransfers = value
            }

            Item {
                width: parent.width
                height: UI.PADDING_DOUBLE
            }

            MySwitch {
                width: parent.width
                text: qsTr("Start transfers automatically")
                checked: Settings.startTransfersAutomatically
                onCheckedChanged: Settings.startTransfersAutomatically = checked
            }
        }
    }

    ScrollDecorator {
        flickableItem: flicker
    }
}
