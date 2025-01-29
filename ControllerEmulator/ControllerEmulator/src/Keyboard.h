#pragma once
#include <Windows.h>

namespace Keyboard
{
	enum Keyboard {
		ESC = VK_ESCAPE,
		Q = 0x51,
		R = 0x52
	};

	bool is_key_pressed(Keyboard key);
}