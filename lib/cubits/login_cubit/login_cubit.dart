import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/cubits/login_cubit/login_state.dart';

import 'package:market/helper/constant.dart';
import 'package:market/helper/dio_helper.dart';
import 'package:market/models/login_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  bool isVisible = true;
  changeVisibilty() {
    isVisible = !isVisible;
    emit(LoginChangeVisibleState());
  }

  loginUser({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: kEndPointLogin,
        data: {'email': email, 'password': password}).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);

      //  print(loginModel!.data!.token);

      emit(LoginSuccessState(loginModel!));
    }).catchError((e) {
      print(e.toString());
    });
  }
}
