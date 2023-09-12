import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:ocr_visitor/models/user_model.dart';
import 'package:ocr_visitor/services/base_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(LoginInitial());
  final API api = API();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  checkToken() async {
    final SharedPreferences preferences = await prefs;
    var token = preferences.getString('token');
    if (token != null) {
      emit(LoginSuccess());
    }
  }

  void login(String email, String password) async {
    final SharedPreferences preferences = await prefs;
    emit(LoginInitial());
    try {
      var response = await api.dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        await preferences.setString(
          'token',
          response.data['data']['access_token'],
        );
        emit(LoginSuccess());
      }
    } catch (e) {
      emit(LoginFailed());
    }
  }

  void logout() async {
    final SharedPreferences preferences = await prefs;
    await preferences.remove('token');
    emit(LogoutSuccess());
  }
}
