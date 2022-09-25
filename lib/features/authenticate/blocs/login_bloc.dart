import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_product/features/authenticate/blocs/login_event.dart';
import 'package:management_product/features/authenticate/blocs/login_state.dart';
import 'package:management_product/features/authenticate/repositories/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(false)) {
    on<LoginEvent>((event, emit) async {
      User? user = await LoginRepository.loginUsingEmailPassword(
        email: event.email,
        password: event.password,
      );
      log(user.toString());

      if (user != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        await sharedPreferences.setString('userId', user.uid);

        emit(LoginState(true));
      } else {
        emit(LoginState(false));
      }
    });
  }
}
