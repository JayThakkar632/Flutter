import 'dart:async';
import 'package:first_flutter_demo_app/presentation/user_module_with_bloc/bloc/user_event.dart';
import 'package:first_flutter_demo_app/presentation/user_module_with_bloc/bloc/user_state.dart';
import 'package:first_flutter_demo_app/presentation/user_module_with_bloc/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/user_details.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class UserBloc extends Bloc<UserEvent,UserState>{
  final UserRepository _userRepository;

  Connectivity _connectivity=Connectivity();
  StreamSubscription? connectivitySubscription;

  UserBloc(this._userRepository):super(UserLoadingState()){
    on<InternetLostEvent>((event,emit)=>emit(InternetLostState()));
    on<UserLoadedEvent>((event,emit)=>emit(UserSuccessState(userDetailsList: [])));
    connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) async {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        emit(UserLoadingState());
        try{
          List<UserDetails>userDetailsList;
          userDetailsList=await _userRepository.getUserList();
          emit(UserSuccessState(userDetailsList: userDetailsList));
        }catch(e){
          emit(UserErrorState(error: e.toString()));
        }
      }else{
        add(InternetLostEvent());
      }
    });

  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }


}