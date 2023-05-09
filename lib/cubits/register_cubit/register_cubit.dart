import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:market/cubits/register_cubit/register_state.dart';

import 'package:market/helper/constant.dart';
import 'package:market/helper/dio_helper.dart';
import 'package:market/models/login_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  LoginModel? registerModel;
  bool isVisible = true;
  changeVisibilty() {
    isVisible = !isVisible;
    emit(RegisterChangeVisibleState());
  }

  registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: kEndPointRegister, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone
    }).then((value) {
      print(value.data);
      registerModel = LoginModel.fromJson(value.data);
     
      print(registerModel!.message);

      emit(RegisterSuccessState(registerModel!));
    }).catchError((e) {
      print(e.toString());
    });
  }
}
