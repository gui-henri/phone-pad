#include "UDPListenner.h"
#include "Keyboard.h"
#include "Controller.h"

int main()
{
    bool quit = false;
    while (!quit)
    {
        Network::UDPListenner server;
        server.connect();

        Controller::ControllerEmulator controller;

        std::cout << "Listening controler. Hold Q or ESC to quit. Hold R to disconnect and restart." << std::endl;

        while (true)
        {
            auto response = server.proccess_blocking();
            if (response.command == "R") break;
            if (response.err == 1) break;
            if (response.command == "Q") {
                quit = true;
                break;
            }

            controller.update(response);
        }
    }
}