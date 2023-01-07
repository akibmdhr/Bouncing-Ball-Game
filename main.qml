import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: main
    width: 640
    height: 500
    visible: true
    title: qsTr("Bouncing Ball Game")
    property bool started: false
    property int missp: 0
    property int hitp: 0

    Text{
        id: text
        font.pixelSize: 14
        anchors.left: parent.left
        anchors.top: parent.top
        color: "Brown"
        font.bold : true
        anchors.leftMargin: main.width*0.4
        anchors.topMargin: 5
        text: qsTr("CLICK ON THE SCREEN TO PLAY!!!")
    }
    Text{
        id: pmiss
        font.pixelSize: 24
        anchors.left: parent.left
        anchors.top: parent.top
        font.bold : true
        color: "Brown"
        anchors.leftMargin: main.width*0.05
        anchors.topMargin: 5
        text: qsTr("Miss: ")
    }
    Text{
        id: phit
        font.pixelSize: 24
        anchors.left: parent.left
        anchors.top: parent.top
        color: "Brown"
        font.bold : true
        anchors.leftMargin: main.width*0.8
        anchors.topMargin: 5
        text: qsTr("Hit: ")
    }
    //Start of the Playground
    Rectangle{
        id: playGround
        property int clickCount: 0

        anchors.fill: parent
        anchors.margins: 10
        anchors.topMargin: 36
        color: "lightGreen"

        //properties of the ball

        Rectangle {
            id: ball
            property double altitude: 100
            property double velocity: 1
            property double gravity: -1.5
            property double force: 0

            property double xincrement: Math.random() + 0.5
            property double yincrement: Math.random() + 0.5

            property int move: 5

            width: 20
            height: width
            radius: width / 2
            color: "#A12345"
            x: parent.width / 2 - width / 2
            y: parent.height / 3 * 2.75 - altitude

            function update() {
                //to make a ball bounce.
                if (altitude <= 12) {
                    force = 30
                    velocity = 5

                    //changing the direction randomly if on the playground.

                    if(ball.x >= 105 && ball.x <= playGround.width - 105)
                    {
                        move = Math.floor(Math.random() * playGround.width*0.03)
                        // direction changing.

                        move = move * (Math.random() < 0.5 ? -1 : 1);
                    }
                    if(main.started === true)
                    {

                        console.log("bar x", bar.x)
                        console.log("ball x", ball.x)
                        if(ball.x > (bar.x - 10) && ball.x < (bar.x+bar.width + 1)){
                            text.text = "Hit"
                            main.hitp ++
                            phit.text = "Hit: " + main.hitp
                        }
                        else
                        {
                            text.text = "Miss"
                            main.missp ++
                            pmiss.text = "Miss: " + main.missp
                        }

                    }
                }
                //moving the ball down
                else
                {
                    force = 0
                }

                //right ball strike The playground will rebound.
                if(ball.x >= playGround.width - 20)
                {
                   move = -Math.floor(Math.random() * playGround.width*0.03)
                }

                //When a ball strikes the left playground, it will rebound.
                if(ball.x <= 20 )
                {
                    move = Math.floor(Math.random() * playGround.width*0.03)
                }

                //preparing the ball to move
                ball.x += move

                //increased speed as a result of bouncing
                velocity += gravity + force

                //shift in altitude.
                altitude += velocity
            }

            Timer {
                running: true
                interval: 33
                repeat: true
                onTriggered: ball.update()
            }
        } // End of the ball

        //the bar
        Rectangle{
            id: bar
            width: 100
            height: 20
            color: "#A16786"
            anchors.bottom: parent.bottom
            x: parent.width / 2 - width / 2
            y: parent.height / 3 * 2.75 -5

            Keys.onPressed: {
                   if (event.key === Qt.Key_Left) {
                        event.accepted = true;
                        bar.x-=30;
                    }
                   if (event.key === Qt.Key_Right) {
                        event.accepted = true;
                        bar.x+=30;
                    }
                }
        }

        MouseArea {
            anchors.fill: parent
            drag.target: root
            onPressed: {
                text.text = "Miss"
                text.anchors.leftMargin = main.width*0.45
                bar.focus = true
                main.started = true
            }
        } //End of the mouse Area
    } //End of the Playground
} //End of the Main Window
