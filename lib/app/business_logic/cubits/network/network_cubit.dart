import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app/business_logic/cubits/network/network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit() : super(NetworkState());

  void checkConnection() async{
    final connection = await Connectivity().checkConnectivity();
    if(connection != ConnectivityResult.none) {
      emit(state.copyWith(status: NetworkStatus.connected));
    } else {
      emit(state.copyWith(status: NetworkStatus.disconnected));
    }
  }
}