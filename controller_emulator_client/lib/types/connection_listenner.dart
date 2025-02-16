abstract interface class ConnectionListener {
  late int id;
  void onConnected();
  void onDisconnected();
  void onUpdatedConnection();
}
