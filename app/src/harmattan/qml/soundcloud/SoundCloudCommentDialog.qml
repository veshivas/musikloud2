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
import QSoundCloud 1.0 as QSoundCloud
import ".."
import "file:///usr/lib/qt4/imports/com/nokia/meego/UIConstants.js" as UI

MySheet {
    id: root

    property string trackId

    acceptWhenDone: false
    showProgressIndicator: comment.status == QSoundCloud.ResourcesRequest.Loading
    rejectButtonText: qsTr("Cancel")
    acceptButtonText: commentField.text ? qsTr("Done") : ""
    content: Item {
        id: contentItem

        anchors.fill: parent
        clip: true

        Flickable {
            id: flicker

            anchors.fill: parent
            contentHeight: column.height + UI.PADDING_DOUBLE

            Column {
                id: column

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    margins: UI.PADDING_DOUBLE
                }
                spacing: UI.PADDING_DOUBLE

                Label {
                    font.bold: true
                    text: qsTr("Comment")
                }

                MyTextArea {
                    id: commentField

                    width: parent.width
                }
            }
        }

        ScrollDecorator {
            flickableItem: flicker
        }
    }

    SoundCloudComment {
        id: comment

        onStatusChanged: {
            switch (status) {
            case QSoundCloud.ResourcesRequest.Ready:
                root.accept();
                break;
            case QSoundCloud.ResourcesRequest.Failed:
                infoBanner.showMessage(errorString);
                break;
            default:
                break;
            }
        }
    }

    onDone: {
        var c = {};
        c["track_id"] = trackId;
        c["body"] = commentField.text;
        comment.addComment(c);
    }

    onStatusChanged: {
        if (status == DialogStatus.Closed) {
            trackId = "";
            commentField.text = "";
        }
    }
}
