#pragma once

#define WIN32_LEAN_AND_MEAN

#include <windows.h>
#include <Xinput.h>
#include <ViGEm/Client.h>
#include "UDPListenner.h"

#pragma comment(lib, "setupapi.lib")

namespace Controller
{
	class ControllerEmulator
	{
	public:
		ControllerEmulator();
		~ControllerEmulator();
		void update(Network::Command) const;

	private:
		PVIGEM_CLIENT m_client;
		PVIGEM_TARGET m_pad;
	};
}