
# importing GPOs RPI
import RPi.GPIO as GPIO

# clean up GPIO
GPIO.cleanup()

# setting up GPIO mode
GPIO.setmode(GPIO.BCM)

# GPIO setting up
GPIO.setup(21, GPIO.OUT)

GPIO.output(21, GPIO.HIGH)
