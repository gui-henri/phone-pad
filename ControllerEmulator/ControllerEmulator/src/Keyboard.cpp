#include "Keyboard.h"

namespace Keyboard
{
	bool is_key_pressed(Keyboard key) {
		if (GetAsyncKeyState(key) & 0x8000) {
			return true;
		}
		return false;
	}
}