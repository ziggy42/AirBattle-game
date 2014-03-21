AirBattle-game
==============

This is a simple, multi-platform game written completely in QML/Javascript.
I've tested it on Android (4.1.2 and 4.4.2) and Ubuntu (12.04).

Screenshots
--------------

![screenshot](http://s27.postimg.org/q8426to3n/g3233.png)



Usage
--------------
To try this code on the desktop, simply download and extract the archive and:

    qmlscene main.qml
    
To try it on Android, you need to set up a project with QtCreator, add Android kit and put this code on ProjectName/qml/ProjectName. 
You may also want to add a custom Androidmanifest.xml and to set:
    
    android:screenOrientation="portrait" 

to disable landscape mode on your phone.

This code should also work on OSX, Windows, iOS, and windows phone  but I've not tried yet.
    
