import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarab/cubit/login_cubit/login_states.dart';

import '../../models/login_model.dart';
import '../../network/endpoints.dart';
import '../../network/remote/dio_helper.dart';



class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData passwordIcon = Icons.visibility_off;
  late LoginModel loginModel;

  changePasswordState() {
    isPassword = !isPassword;
    passwordIcon = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(LoginChangePasswordVisibility());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: LOGIN_END_POINT,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data.toString());
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.data?.email);
      emit(LoginSuccessState(loginModel));
    }).catchError(
      (error) {
        print(error.toString());
        emit(LoginErrorState(error.toString()));
      },
    );
  }




}
