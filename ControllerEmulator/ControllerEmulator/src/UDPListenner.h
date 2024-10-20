#pragma once
#include <iostream>
#include <string>
#include <WinSock2.h>
#include <ws2tcpip.h>
#include <assert.h>
#include "Keyboard.h"

namespace Network
{
	const unsigned int BUFFER_LENGHT = 256;
	const unsigned int PORT = 4321;

	class UDPListenner
	{
	public:
		UDPListenner();
		~UDPListenner();

		void run();
		void set_timeout(long p_seconds, long p_nanoseconds);
		void set_exit_request(bool p_exitRequest);
		

	private:
		WSADATA			m_wsa{};
		SOCKET			m_serverSocket = 0;
		sockaddr_in		m_serverAddr{}, m_clientAddr{};
		fd_set			m_readfds = {};
		timeval			m_timeout;
		u_short			m_port = 0;
		char			m_message[BUFFER_LENGHT] = {};
		char			m_ipAddrs[INET_ADDRSTRLEN] = {};
		bool			m_exitRequested = false;

		int		receive_messages(int p_selectState);
		int		check_incoming_data();
		void	clear_client_message();
		bool	check_exit_request();
		void	print_message() const;
		int		send(const char p_message[]);
		int		listen_incomming_client();

	};

	enum IncommingClientResults {
		CONNECTION_SUCCESS = 0, CHECK_INCOMMING_DATA_ERROR, STOP_LISTENNING
	};

	enum ReceiveMessagesResults {
		MESSAGE_SUCCESS = 0, RECEIVE_ERROR, NO_MESSAGE
	};

	enum SendMessageResults {
		SEND_SUCCESS = 0, SEND_ERROR
	};
}