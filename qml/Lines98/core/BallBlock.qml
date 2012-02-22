// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import Qt.labs.particles 1.0
import "Constants.js" as Constant

Item{
    id: block
    property int ballState
    property int type: 0

    Behavior on x {
        SpringAnimation{ spring: 2; damping: 0.2 }
    }
    Behavior on y {
        SpringAnimation{ spring: 2; damping: 0.2 }
    }

    Image {
        id: img
        source: {
            if(type == Constant.RED_BALL){
                "pics/redStone.png";
            } else if(type == Constant.BLUE_BALL) {
                "pics/blueStone.png";
            } else if(type == Constant.GREEN_BALL){
                "pics/greenStone.png";
            } else if(type == Constant.YELLOW_BALL){
                "pics/yellowStone.png";
            }else if(type == Constant.PURPLE_BALL){
                "pics/purpleStone.png";
            }else {
                console.debug("WTF");
            }
        }
        opacity: 0
        //Behavior on opacity { NumberAnimation { duration: 200 } }
        anchors.centerIn: parent
        NumberAnimation on opacity {
            id: animation
            running: ballState == Constant.SELECT_BALL
            loops: Animation.Infinite
            from: 0; to: 1
            duration: 1000
        }
    }

    Particles {
        id: particles

        width: 1; height: 1
        anchors.centerIn: parent

        emissionRate: 0
        lifeSpan: 700; lifeSpanDeviation: 600
        angle: 0; angleDeviation: 360;
        velocity: 100; velocityDeviation: 30
        source: {
            if(type == Constant.RED_BALL){
                "pics/redStar.png";
            } else if (type == Constant.BLUE_BALL) {
                "pics/blueStar.png";
            } else if (type == Constant.GREEN_BALL){
                "pics/greenStar.png";
            }else if (type == Constant.YELLOW_BALL){
                "pics/yellowStar.png";
            }else if (type == Constant.PURPLE_BALL){
                "pics/purpleStar.png";
            }
        }
    }


    states: [
        State{
            name: "InitialState"; when: ballState == Constant.INIT_BALL
            PropertyChanges { target: img; opacity: 1; scale: 0.5}
        },
        State {
            name: "AliveState"; when: ballState == Constant.ALIVE_BALL
            PropertyChanges { target: img; opacity: 1; scale: 1}
        },
        State{
            name: "SelectedState"; when: ballState == Constant.SELECT_BALL
            PropertyChanges { target: img; opacity: 1; scale: 1}
            StateChangeScript { script: animation.start() }
        },
        State {
            name: "DeathState"; when: ballState == Constant.DEATH_BALL
            StateChangeScript { script: particles.burst(50); }
            PropertyChanges { target: img; opacity: 0 }
            StateChangeScript { script: block.destroy(1000); }
        }
    ]
}
