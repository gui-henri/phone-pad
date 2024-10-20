#pragma once
#include <Windows.h>

namespace Keyboard
{
	enum Keyboard {
		ESC = VK_ESCAPE,
		Q = 0x51
	};

	bool is_key_pressed(Keyboard key);
}