sudo chmod 777 /sys/class/net/wwan0/qmi/raw_ip

sudo qmicli --device=/dev/cdc-wdm0 --device-open-proxy --get-wwan-iface

sudo qmicli --device=/dev/cdc-wdm0 --get-expected-data-format

sudo ip link set dev wwan0 down

sudo echo Y > /sys/class/net/wwan0/qmi/raw_ip

sudo ip link set dev wwan0 up

sudo qmicli --device=/dev/cdc-wdm0 --device-open-proxy --wds-start-network="ip-type=4, apn=celcom4g" --client-no-release-cid

sudo udhcpc -q -f -n -i wwan0

ping -4 www.google.com
