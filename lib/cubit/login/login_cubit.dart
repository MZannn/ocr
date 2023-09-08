import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ocr_visitor/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  Future<void> setUser() async {
    final SharedPreferences preferences = await prefs;
    await preferences.setString(
      'user',
      jsonEncode(
        UserModel(email: 'admin@gmail.com', password: 'admin'),
      ),
    );
  }

  void login(String email, String password) async {
    emit(LoginLoading());
    final SharedPreferences preferences = await prefs;
    var user = preferences.getString('user');
    var userMap = jsonDecode(user!);
    var userModel = UserModel.fromJson(userMap);
    if (email == userModel.email && password == userModel.password) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailed());
    }
  }
}
