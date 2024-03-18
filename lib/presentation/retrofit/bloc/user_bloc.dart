import '../data/service/api_service.dart';
import 'user_event.dart';
import 'user_state.dart';
import 'package:bloc/bloc.dart';

class UserBloc extends Bloc<UserEvent,UserState>{
  final ApiService apiService;

  UserBloc({required this.apiService}):super(UserLoadingState()){
    on<UserLoadedEvent>((event,emit) async{
      try{
        var data=await apiService.getData();
        emit(UserSuccessState(userDetailsList: data));
      }catch(e){
        emit(UserErrorState(error: e.toString()));
      }
    });
  }
}