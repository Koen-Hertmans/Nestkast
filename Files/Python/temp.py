import time
import adafruit_dht
import board
from datetime import datetime

now = datetime.now()
dht = adafruit_dht.DHT11(board.D2)
dht2 = adafruit_dht.DHT11(board.D3)
while True:
    try:
        str_date = now.strftime("%d/%m/%Y %H:%M:%S")
        temperature = dht.temperature
        temperature2 = dht2.temperature
        #print("{} \t Temp(binnen): {:.1f} *C \t Temp(buiten): {:.1f} *C".format(str_date, temperature, temperature2))
        f = open("/mnt/USBdrive/Temp/Temp.txt", "a")
        f.write("{} \t Temp(binnen): {:.1f} *C \t Temp(buiten): {:.1f} *C \n".format(str_date, temperature, temperature2))
        f.close()
    except RuntimeError as e:
        print("Reading from DHT failure: ", e.args)

    time.sleep(300)

