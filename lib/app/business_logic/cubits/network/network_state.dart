enum NetworkStatus {
  connected,
  disconnected,
  timedOut;

  bool get isConnected => this == NetworkStatus.connected;
  bool get isDisconnected => this == NetworkStatus.disconnected;
  bool get isTimedOut => this == NetworkStatus.timedOut;
}

class NetworkState {
  final NetworkStatus status;

  NetworkState({this.status = NetworkStatus.connected});

  NetworkState copyWith({
    required NetworkStatus status,
  }) {
    return NetworkState(
      status: status,
    );
  }
}
