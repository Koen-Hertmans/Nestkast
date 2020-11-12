from picamera import PiCamera
from gpiozero import MotionSensor
from datetime import datetime
from time import sleep

camera = PiCamera()
pir = MotionSensor(4)
teller = 0
recording=0


while True:
	if pir.motion_detected==True:
		if recording == 0:
			now = datetime.now()
			date = now.strftime("%d-%m-%Y %H:%M:%S")
			camera.start_recording("/mnt/USBdrive/Video/motiontest%s.h264" %date)
			#print("start recording")
			recording = 1
		while recording == 1: 
			sleep(1)
			teller = teller+1
			if pir.motion_detected ==False:
				camera.stop_recording()
				#print("stop recording")
				#print(teller)
				recording = 0
				teller = 0
			if teller >=300:
				camera.stop_recording()
				#print("stop recording")
				#print(teller)
				teller=0
				recording=0
