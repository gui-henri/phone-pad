# PhonePad
PhonePad turns your phone into an Xbox controller for PC, allowing you to play any game with commands sent over the local network. The project consists of two applications: a server for PC (Windows) and a client for mobile devices (Android, iOS, Web, Linux, macOS, Windows).

<img width="500" height="400" alt="image" src="https://github.com/user-attachments/assets/ba444281-fe2f-4e01-b367-95ae9f0124b8" />
<br>

Video demonstration [here on my Youtube](https://youtu.be/2uei8RFcpQ8?si=6W9nSl3CJHkd9hr9)

### Features
* Wireless PC control using your phone
* Motion sensor support (gyroscope, accelerometer)
* Customizable interface (coming soon)
* Easy connection via local network
* Compatible with any game that accepts an Xbox controller

### How it works
* Server (PC): Receives commands from the phone and emulates an Xbox controller using the ViGEmBus driver.
* Client (Phone): Captures user commands and sends them to the PC over the network.

### Installation
#### Windows
* Go to the website and click Download
* Extract the files, it comes with all the installers you need.
* Install the ViGEmBus driver.
* Install the PhonePad app on your phone.
Thats it

#### Other platforms
The server can be only present on Windows. iPhone Version for the client soon.

To run locally, install Flutter and run:

```Bash
flutter pub get
flutter run
```
### How to use
* Open the PhonePad Server on the PC.
* Open the PhonePad app on the phone.
* Connect both to the same Wi-Fi network.
* In the app, press start.

Use your phone as a controller!

### Credits
* Developer: Galego (gui-henri)
* Powered by SIDU (soon to be open source)
* Powered by ViGEmBus

### License

This project is not open source. The source code is made available under the PolyForm Shield License 1.0.0.

This license is designed to be highly restrictive to protect the project from unauthorized commercial use and distribution. Please read the summary below carefully.

#### Key Permissions and Restrictions:
##### You are free to:
* View the source code.
* Use and modify the software for your own personal or internal business purposes.

##### You are strictly forbidden from:

* Making the software available to anyone other than yourself (i.e., no redistribution).
* Using the software to provide a service to others (e.g., as a commercial SaaS offering).
* Removing or obscuring any license notices.

The goal is to provide transparency and allow users to modify the software for their own use, while preventing it from being sold or distributed by others.
For the full legal text, please read the legal text online at https://polyformproject.org/licenses/shield/1.0.0/.
