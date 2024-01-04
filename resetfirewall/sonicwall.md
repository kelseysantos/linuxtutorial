# Reset SonicWall

 - You will need a computer or laptop with an Ethernet cable and the ability to set a static IP address on the computer.

1. Hold down the reset button for 10 seconds. On a TZ the reset button is located next to the power jack. On an NSa the reset button is located on the front. Once the test light on the device becomes solid or begins to blink then the SonicWall is in safe mode.
1. The device will reboot when you release the reset button.
1. Set your computers IP address to **192.168.168.167** MASK **255.255.255.0**.
1. Connect your computer to the LAN port on the SonicWALL TZ.
1. After the device reboots it will be in recovery mode. Connect to at at **http://192.168.168.168**
1. Click the boot icon next to “**Current Firmware with Factory Default Settings.**”
1. After the device reboots, you can again connect to it at the 192.168.168.168 address. The default login is: **admin** and **password**.
1. At this point the device is reset to factory defaults.