import '../../models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}
class RegisterChangeVisibleState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterFailureState extends RegisterStates {}
