import 'package:first_flutter_demo_app/presentation/retrofit/data/model/user_model.dart';

class UserState{}

class UserLoadingState extends UserState{}

class UserSuccessState extends UserState{
  final List<UserModel> userDetailsList;
  UserSuccessState({required this.userDetailsList});
}
class UserErrorState extends UserState{
  String error;
  UserErrorState({required this.error});
}
