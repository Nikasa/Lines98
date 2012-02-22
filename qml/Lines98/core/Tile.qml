/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the QtDeclarative module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this
** file. Please review the following information to ensure the GNU Lesser
** General Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights. These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU General
** Public License version 3.0 as published by the Free Software Foundation
** and appearing in the file LICENSE.GPL included in the packaging of this
** file. Please review the following information to ensure the GNU General
** Public License version 3.0 requirements will be met:
** http://www.gnu.org/copyleft/gpl.html.
**
** Other Usage
** Alternatively, this file may be used in accordance with the terms and
** conditions contained in a signed written agreement between you and Nokia.
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.0
//import "lines.js" as Logic
import "Constants.js" as Constant

Item {
    id: tile
    property int angle: 0

    width: 50;  height: 50
    transform: Rotation { origin.x: 20; origin.y: 20; axis.x: 1; axis.z: 0; angle: tile.angle }
    property bool displayPath: false
    Image {
        id: img
        source: "pics/front.png"
        width: 50; height: 50
    }
    Timer{
        id : pathTimer
        interval: 100
        repeat: false
        onTriggered: state=""
    }

    states: [
        State{name: "pathDisplay"; when: displayPath == true
            PropertyChanges {
                target: img
                source: "pics/back.png"
            }
            StateChangeScript{script: pathTimer.start();}
        }
    ]

}
