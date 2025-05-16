#include <iostream>
#include "Controller.h"

namespace Controller
{
    ControllerEmulator::ControllerEmulator()
    {
        m_client = vigem_alloc();
        if (m_client == nullptr)
        {
            std::cerr << "Uh, not enough memory to do that?!" << std::endl;
            throw std::runtime_error("Failed to allocate memory for m_client.");
        }

        const auto retval = vigem_connect(m_client);

        if (!VIGEM_SUCCESS(retval))
        {
            std::cerr << "ViGEm Bus connection failed with error code: 0x" << std::hex << retval << std::endl;
            throw std::runtime_error("Failed to retval.");
        }

        m_pad = vigem_target_x360_alloc();
        const auto pir = vigem_target_add(m_client, m_pad);

        if (!VIGEM_SUCCESS(pir))
        {
            std::cerr << "Target plugin failed with error code: 0x" << std::hex << pir << std::endl;
            throw std::runtime_error("failed m_pad.");
        }
    }

    ControllerEmulator::~ControllerEmulator()
    {
        vigem_target_remove(m_client, m_pad);
        vigem_target_free(m_pad);
        vigem_disconnect(m_client);
        vigem_free(m_client);
    }


    // 0 not pressed
    // 1 both pressed
    // byte 0: ~
    // byte 1: AB Buttons 
    // byte 2: XY Buttons 
    // byte 3: Start and sElect 
    // byte 4: D-Left and D-Right 
    // byte 5: D-Up and D-Down 
    // byte 6: LB and RB
    // byte 7: TL and TR
    // byte 8: LT and RT
    // byte 9 and 10: L-Stick-X
    // byte 11 and 12: L-Stick-Y
    // byte 13 and 14: L-Stick-X
    // byte 16 and 15: L-Stick-Y
    // byte 17: ~
    // ex:
    // ~A000000012874712~

    struct ButtonByte {
        WORD first;
        WORD second;
    };

    static ButtonByte getButton(int i)
    {
        switch (i)
        {
            case 1: return { XINPUT_GAMEPAD_A, XINPUT_GAMEPAD_B };
            case 2: return { XINPUT_GAMEPAD_X, XINPUT_GAMEPAD_Y };
            case 3: return { XINPUT_GAMEPAD_START, XINPUT_GAMEPAD_BACK };
            case 4: return { XINPUT_GAMEPAD_DPAD_LEFT, XINPUT_GAMEPAD_DPAD_RIGHT };
            case 5: return { XINPUT_GAMEPAD_DPAD_UP, XINPUT_GAMEPAD_DPAD_DOWN };
            case 6: return { XINPUT_GAMEPAD_LEFT_SHOULDER, XINPUT_GAMEPAD_RIGHT_SHOULDER };
            case 7: return { XINPUT_GAMEPAD_LEFT_THUMB, XINPUT_GAMEPAD_RIGHT_THUMB };
            default: break;
        }

        return { 0, 0 };
    }

    int get_digit(char first, char second)
    {
        int digit1 = first - '0';
        int digit2 = second - '0';
        return digit1 * 10 + digit2;
    }

    int map_range(int input)
    {
        int minInput = 0;
        int maxInput = 99;

        int minOutput = -32768;
        int maxOutput = 32767;

        int mappedValue = static_cast<int>(
            ((input - minInput) * (maxOutput - minOutput)) / (maxInput - minInput) + minOutput
        );
        return max(minOutput, min(mappedValue, maxOutput));
    }

    void ControllerEmulator::update(Network::Command response) const 
    {
        if (response.command == nullptr || strlen(response.command) < 18) {
            return;
        }

        if (response.command[0] != '~' || response.command[17] != '~')
        {
            return;
        }

        XINPUT_STATE state = {};

        for (int i = 1; i < 8; ++i)
        {
            ButtonByte possibleButtons = getButton(i);
            char button = response.command[i];

            if ( button == 'A') {
                state.Gamepad.wButtons |= possibleButtons.first;
            }
            if (button == 'B') {
                state.Gamepad.wButtons |= possibleButtons.second;
            }

            if (button == '1') {
                state.Gamepad.wButtons |= possibleButtons.first;
                state.Gamepad.wButtons |= possibleButtons.second;
            }
        }

        if (response.command[8] == 'A') state.Gamepad.bLeftTrigger = 255;
        if (response.command[8] == 'B') state.Gamepad.bRightTrigger = 255;
        if (response.command[8] == '1') {
            state.Gamepad.bLeftTrigger = 255;
            state.Gamepad.bRightTrigger = 255;
        }

        int l_stick_x = get_digit(response.command[9], response.command[10]);
        int l_stick_y = get_digit(response.command[11], response.command[12]);

        state.Gamepad.sThumbLX = map_range(l_stick_x);
        state.Gamepad.sThumbLY = map_range(l_stick_y);

        int r_stick_x = get_digit(response.command[13], response.command[14]);
        int r_stick_y = get_digit(response.command[15], response.command[16]);

        state.Gamepad.sThumbRX = map_range(r_stick_x);
        state.Gamepad.sThumbRY = map_range(r_stick_y);

        vigem_target_x360_update(m_client, m_pad, *reinterpret_cast<XUSB_REPORT*>(&state.Gamepad));
    }
}