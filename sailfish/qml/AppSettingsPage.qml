/*
    Quickddit - Reddit client for mobile phones
    Copyright (C) 2014  Dickson Leong
    Copyright (C) 2015-2018  Sander van Grieken

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see [http://www.gnu.org/licenses/].
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.quickddit.Core 1.0

AbstractPage {
    id: appSettingsPage
    title: qsTr("App Settings")

    SilicaListView {
        id: settingFlickable
        anchors.fill: parent

        header: Column {
            id: settingColumn
            width: parent.width

            QuickdditPageHeader { title: appSettingsPage.title }

            SectionHeader { text: qsTr("UX") }

            ComboBox {
                label: qsTr("Font Size")
                currentIndex:  {
                    switch (appSettings.fontSize) {
                    case AppSettings.TinyFontSize: return 0;
                    case AppSettings.SmallFontSize: return 1;
                    case AppSettings.MediumFontSize: return 2;
                    case AppSettings.LargeFontSize: return 3;
                    }
                }
                menu: ContextMenu {
                    MenuItem { text: qsTr("Tiny"); font.pixelSize: constant.fontSizeXSmall }
                    MenuItem { text: qsTr("Small"); font.pixelSize: constant.fontSizeSmall }
                    MenuItem { text: qsTr("Medium"); font.pixelSize: constant.fontSizeMedium }
                    MenuItem { text: qsTr("Large"); font.pixelSize: constant.fontSizeLarge }
                }
                onCurrentIndexChanged: {
                    switch (currentIndex) {
                    case 0: appSettings.fontSize = AppSettings.TinyFontSize; break;
                    case 1: appSettings.fontSize = AppSettings.SmallFontSize; break;
                    case 2: appSettings.fontSize = AppSettings.MediumFontSize; break;
                    case 3: appSettings.fontSize = AppSettings.LargeFontSize; break;
                    }
                }
            }

            ComboBox {
                label: qsTr("Device Orientation")
                currentIndex:  {
                    switch (appSettings.orientationProfile) {
                    case AppSettings.DynamicProfile: return 0;
                    case AppSettings.PortraitOnlyProfile: return 1;
                    case AppSettings.LandscapeOnlyProfile: return 2;
                    }
                }
                menu: ContextMenu {
                    MenuItem { text: qsTr("Automatic") }
                    MenuItem { text: qsTr("Portrait only") }
                    MenuItem { text: qsTr("Landscape only") }
                }
                onCurrentIndexChanged: {
                    switch (currentIndex) {
                    case 0: appSettings.orientationProfile = AppSettings.DynamicProfile; break;
                    case 1: appSettings.orientationProfile = AppSettings.PortraitOnlyProfile; break;
                    case 2: appSettings.orientationProfile = AppSettings.LandscapeOnlyProfile; break;
                    }
                }
            }

            ComboBox {
                label: qsTr("Thumbnail Size")
                currentIndex:  {
                    switch (appSettings.thumbnailScale) {
                    case AppSettings.ScaleAuto: return 0;
                    case AppSettings.Scale100: return 1;
                    case AppSettings.Scale125: return 2;
                    case AppSettings.Scale150: return 3;
                    case AppSettings.Scale175: return 4;
                    case AppSettings.Scale200: return 5;
                    case AppSettings.Scale250: return 6;
                    }
                }
                menu: ContextMenu {
                    MenuItem { text: qsTr("Auto") }
                    MenuItem { text: "x1" }
                    MenuItem { text: "x1.25" }
                    MenuItem { text: "x1.5" }
                    MenuItem { text: "x1.75" }
                    MenuItem { text: "x2" }
                    MenuItem { text: "x2.5" }
                }
                onCurrentIndexChanged: {
                    switch (currentIndex) {
                    case 0: appSettings.thumbnailScale = AppSettings.ScaleAuto; break;
                    case 1: appSettings.thumbnailScale = AppSettings.Scale100; break;
                    case 2: appSettings.thumbnailScale = AppSettings.Scale125; break;
                    case 3: appSettings.thumbnailScale = AppSettings.Scale150; break;
                    case 4: appSettings.thumbnailScale = AppSettings.Scale175; break;
                    case 5: appSettings.thumbnailScale = AppSettings.Scale200; break;
                    case 6: appSettings.thumbnailScale = AppSettings.Scale250; break;
                    }
                }
            }

            TextSwitch {
                text: qsTr("Thumbnail Link Type Indicator")
                checked: appSettings.showLinkType;
                onCheckedChanged: {
                    appSettings.showLinkType = checked;
                }
            }

            TextSwitch {
                text: qsTr("Comments Tap To Hide")
                checked: appSettings.commentsTapToHide;
                onCheckedChanged: {
                    appSettings.commentsTapToHide = checked;
                }
            }

            SectionHeader { text: qsTr("Notifications") }

            TextSwitch {
                text: qsTr("Check Messages")
                checked: appSettings.pollUnread;
                enabled: quickdditManager.isSignedIn
                onCheckedChanged: {
                    appSettings.pollUnread = checked;
                }
            }

            SectionHeader { text: qsTr("Media") }

            ComboBox {
                label: qsTr("Preferred Video Size")
                currentIndex:  {
                    switch (appSettings.preferredVideoSize) {
                    case AppSettings.VS360: return 0;
                    case AppSettings.VS720: return 1;
                    }
                }
                menu: ContextMenu {
                    MenuItem { text: "360p" }
                    MenuItem { text: "720p" }
                }
                onCurrentIndexChanged: {
                    switch (currentIndex) {
                    case 0: appSettings.preferredVideoSize = AppSettings.VS360; break;
                    case 1: appSettings.preferredVideoSize = AppSettings.VS720; break;
                    }
                }
            }

            TextSwitch {
                text: qsTr("Loop Videos")
                checked: appSettings.loopVideos;
                onCheckedChanged: {
                    appSettings.loopVideos = checked;
                }
            }

            SectionHeader { text: qsTr("Connection") }

            TextSwitch {
                text: qsTr("Use Tor")
                description: qsTr("When enabled, please make sure Tor is installed and active.")
                checked: appSettings.useTor;
                onCheckedChanged: {
                    appSettings.useTor = checked;
                }
            }

            SectionHeader { text: qsTr("Account") }

            Text {
                anchors { left: parent.left; right: parent.right }
                font.pixelSize: constant.fontSizeMedium
                color: constant.colorLight
                horizontalAlignment: Text.AlignHCenter
                text: quickdditManager.isSignedIn ? qsTr("Signed in to Reddit as") : qsTr("Not signed in")
            }

            Text {
                anchors { left: parent.left; right: parent.right }
                font.pixelSize: constant.fontSizeLarge
                color: Theme.secondaryHighlightColor
                visible: quickdditManager.isSignedIn
                horizontalAlignment: Text.AlignHCenter
                text: appSettings.redditUsername
            }

            Rectangle {
                color: "transparent"
                height: 20
                width: 1
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: constant.paddingMedium

                Button {
                    text: quickdditManager.isSignedIn ? qsTr("Sign out") : qsTr("Sign in to Reddit")
                    onClicked: {
                        if (quickdditManager.isSignedIn) {
                            quickdditManager.signOut();
                            infoBanner.alert(qsTr("You have signed out from Reddit"));
                         } else {
                            pageStack.push(Qt.resolvedUrl("SignInPage.qml"));
                        }
                    }
                }

                Button {
                    text: qsTr("Accounts")
                    onClicked: pageStack.push(Qt.resolvedUrl("AccountsPage.qml"));
                }
            }

            Rectangle {
                color: "transparent"
                height: constant.paddingLarge
                width: 1
            }
        }
    }
}
