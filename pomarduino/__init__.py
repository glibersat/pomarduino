import serial, sys

import dbus
from dbus.mainloop.glib import DBusGMainLoop
import gobject

class Pomarduino(object):
    def __init__(self, com_port, baudrate):
        self.com_port = com_port
        self.baudrate = baudrate

        self.dbus_loop = DBusGMainLoop(set_as_default=True)

        self.bus = dbus.SessionBus()
        self.proxy = self.bus.get_object('org.gnome.shell.Pomodoro',
                                         '/org/gnome/shell/Pomodoro')

        self.proxy.connect_to_signal("worksession_start", self._worksession_start)
        self.proxy.connect_to_signal("worksession_end", self._worksession_end)


    def _openSerial(self):
        handler = serial.Serial(port=self.com_port,
                                baudrate=self.baudrate,
                                bytesize=8,
                                parity='N',
                                stopbits=1,
                                timeout=3,
                                xonxoff=0,
                                rtscts=0)
        handler.open()

        return handler


    def _closeSerial(self, serial):
        serial.close()
        
    def _worksession_start(self, seconds):
        serial = self._openSerial()
        
        minutes = int(seconds) / 60
        data = chr(minutes)
        serial.write(data)

        self._closeSerial(serial)

    def _worksession_end(self):
        serial = self._openSerial()
        serial.write(chr(0))

        self._closeSerial(serial)

        
    def main(self):
        loop = gobject.MainLoop()
        loop.run()


