import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/global/states/network_state.dart';

class NetworkStore extends ValueNotifier<NetworkState> {
  NetworkStore() : super(InitialNetworkState());

  Future<void> checkConnection() async {
    final connection = await Connectivity().checkConnectivity();
    if(connection != ConnectivityResult.none) {
      value = SuccessNetworkState();
    } else {
      value = FailureNetworkState();
    }
  }
}
