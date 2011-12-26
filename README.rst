Pomodoro for Arduino
====================

An Arduino sketch plus a python daemon to synchronize your pomodoro
app with an LCD connected to your arduino.

Currently, it only works with my fork_ of gnome-shell-pomodoro (that
adds Dbus support).

.. _fork: https://github.com/glibersat/gnome-shell-pomodoro

Files
-----

sketchbook/ -> The sketch for the arduino

Deps
----

You need python-daemon and python-dbus

Run
---

Edit bin/pomarduino if your Arduino is not connected to '/dev/ttyUSB0'.

Start bin/pomarduino
