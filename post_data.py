# importing the requests library
import requests

# importing GPOs RPI
import RPi.GPIO as GPIO

while (1):

    # clean up GPIO
    GPIO.cleanup()

    # setting up GPIO mode
    GPIO.setmode(GPIO.BCM)

    # GPIO setting up
    GPIO.setup(25, GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(21, GPIO.OUT)

    # defining the api-endpoint
    SERVER_ADD = "http://p.mpw-test.com:9802/api"

    # data to be sent to api
    if GPIO.input(25):
        data = {'data':1}
        GPIO.output(21, GPIO.HIGH)
    else:
        data = {'data':0}
        GPIO.output(21, GPIO.LOW)

    # sending post request and saving response as response object
    r = requests.post(url = SERVER_ADD, data = data)

    # extracting response text
    pastebin_url = r.text
    print("Response:%s"%pastebin_url)
