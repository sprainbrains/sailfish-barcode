/*
The MIT License (MIT)

Copyright (c) 2022 Slava Monich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

import QtQuick 2.0
import harbour.barcode 1.0

Item {
    id: thisItem

    property string mimeType
    property url source

    signal thumbnailError()

    readonly property var thumbnail: Qt.createQmlObject(BarcodeUtils.thumbnailQml, thisItem, "Thumbnail")

    Binding { target: thumbnail; property: "sourceSize"; value: Qt.size(width,height) }
    Binding { target: thumbnail; property: "mimeType"; value: mimeType }
    Binding { target: thumbnail; property: "source"; value: source }

    Connections {
        target: thumbnail
        ignoreUnknownSignals: true
        onStatusChanged: {
            if (thumbnail.status === thumbnail.errorStatus) {
                thisItem.thumbnailError()
            }
        }
    }
}
