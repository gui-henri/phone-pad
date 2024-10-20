#include <ws2tcpip.h>
#include "UDPListenner.h"
constexpr auto CONNECT = "CONNECT";
constexpr auto IP_FOUND = "IP_FOUND";

namespace Network {

	UDPListenner::UDPListenner()
	{

		UDPListenner::set_timeout(0, 16666);
									 
		std::cout << "Initializing server" << std::endl;
		if (WSAStartup(MAKEWORD(2, 2), &m_wsa) != 0) {
			std::cout << "Initialization failed. Couldn't startup WinSockets" << std::endl;
			exit(EXIT_FAILURE);
		}

		if ((m_serverSocket = socket(AF_INET, SOCK_DGRAM, 0)) == INVALID_SOCKET) {
			std::cout << "Initialization failed. Error creating socket by WSA error: " << WSAGetLastError() << std::endl;
			exit(EXIT_FAILURE);
		}

		m_serverAddr.sin_family = AF_INET;
		m_serverAddr.sin_addr.s_addr = INADDR_ANY;
		m_serverAddr.sin_port = htons(PORT);

		if (bind(m_serverSocket, (sockaddr*)&m_serverAddr, sizeof(m_serverAddr)) == SOCKET_ERROR) {
			std::cout << "Initialization failed. Bind failed with error code: " << WSAGetLastError() << std::endl;
			exit(EXIT_FAILURE);
		}

		std::cout << "Binding was a success." << std::endl;
	}

	UDPListenner::~UDPListenner()
	{
		closesocket(m_serverSocket);
		WSACleanup();
	}

	void UDPListenner::run()
	{
		std::cout << "Listening to data on port: " << PORT << std::endl;
		while (!m_exitRequested)
		{
			int res = UDPListenner::listen_incomming_client();

			if (res == IncommingClientResults::CHECK_INCOMMING_DATA_ERROR)
			{
				std::cout << "Something went wrong while listenning to a new client." << std::endl;
				std::cout << "Trying to listen new connections again..." << std::endl;
				continue;
			}
			if (res == IncommingClientResults::STOP_LISTENNING)
			{
				m_exitRequested = true;
				continue;
			}

			std::cout << "WORKLOAD NAO IMPLEMENTADO! O servidor foi "
				<< "capaz de estabelecer uma conexao mas ira fechar agora!" << std::endl;
			break;
		}
	}

	int UDPListenner::check_incoming_data()
	{
		FD_ZERO(&m_readfds);
		FD_SET(m_serverSocket, &m_readfds);

		int ret = select(0, &m_readfds, NULL, NULL, &m_timeout);

		if (ret == SOCKET_ERROR) {
			std::cout << "Erro no select: " << WSAGetLastError() << std::endl;
			return SOCKET_ERROR;
		}

		return ret;
	}

	int UDPListenner::receive_messages(int p_selectState)
	{
		if (p_selectState > 0 && FD_ISSET(m_serverSocket, &m_readfds)) {
			int sockSize = sizeof(sockaddr_in);
			int recvState = recvfrom(m_serverSocket, m_message, BUFFER_LENGHT, 0, (sockaddr*)&m_clientAddr, &sockSize);

			if (recvState == SOCKET_ERROR) {
				std::cout << "recvfrom() failed with error code : " << WSAGetLastError() << "\n";
				return ReceiveMessagesResults::RECEIVE_ERROR;
			}


			assert(m_ipAddrs[0] == '\0');
			assert(m_port == 0);
			inet_ntop(AF_INET, &m_clientAddr.sin_addr, m_ipAddrs, INET_ADDRSTRLEN);
			m_port = ntohs(m_clientAddr.sin_port);

			return ReceiveMessagesResults::MESSAGE_SUCCESS;

		}

		return ReceiveMessagesResults::NO_MESSAGE;
		
	}

	void UDPListenner::set_timeout(long p_seconds, long p_microseconds)
	{
		m_timeout.tv_sec = p_seconds;
		m_timeout.tv_usec = p_microseconds;
	}

	void UDPListenner::set_exit_request(bool p_exitRequest)
	{
		m_exitRequested = p_exitRequest;
	}

	int UDPListenner::send(const char p_message[])
	{
		int res = sendto(m_serverSocket, p_message, strlen(p_message), 0, (sockaddr*)&m_clientAddr, sizeof(sockaddr_in));

		if (res == SOCKET_ERROR) {
			std::cout << "Error sending message to: " << m_ipAddrs << "!" << std::endl;
			std::cout << "Error: " << WSAGetLastError() << std::endl;
			return SEND_ERROR;
		}

		std::cout << "Mensagem enviada para: "
			<< m_ipAddrs << ":"
			<< m_port << std::endl;

		return SEND_SUCCESS;
	}

	int UDPListenner::listen_incomming_client()
	{

		bool listening = true;

		while (listening)
		{
			int res = UDPListenner::check_incoming_data();
			if (res == SOCKET_ERROR) {
				return IncommingClientResults::CHECK_INCOMMING_DATA_ERROR;
			}

			res = UDPListenner::receive_messages(res);
			if (res == ReceiveMessagesResults::RECEIVE_ERROR) {
				return IncommingClientResults::CHECK_INCOMMING_DATA_ERROR;
			}

			if (res == ReceiveMessagesResults::MESSAGE_SUCCESS) {
				UDPListenner::print_message();
				if (strcmp(m_message, CONNECT))
				{
					continue;
				}
				res = UDPListenner::send(IP_FOUND);
				if (res == SendMessageResults::SEND_ERROR) {
					return IncommingClientResults::CHECK_INCOMMING_DATA_ERROR;
				}

				return IncommingClientResults::CONNECTION_SUCCESS;
			}

			listening = !UDPListenner::check_exit_request();
			UDPListenner::clear_client_message();
		}

		return IncommingClientResults::STOP_LISTENNING;
	}

	void UDPListenner::clear_client_message()
	{
		memset(m_message, 0, sizeof(m_message));
		memset(m_ipAddrs, 0, sizeof(m_ipAddrs));
		m_port = 0;
	}

	bool UDPListenner::check_exit_request()
	{
		if (Keyboard::is_key_pressed(Keyboard::ESC))
		{
			std::cout << "Closing server and exiting...\n";
			return true;
		}

		return false;
	}
	void UDPListenner::print_message() const
	{
		assert(m_ipAddrs[0] != '\0');
		assert(m_message[0] != '\0');
		assert(m_port != 0);

		std::cout << "Recebendo mensagens de "
			<< m_ipAddrs
			<< ":" << m_port
			<< std::endl;
		std::cout << "Mensagem: "
			<< m_message
			<< std::endl;
	}
}