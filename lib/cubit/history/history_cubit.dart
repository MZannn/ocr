import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ocr_visitor/models/history_models.dart';
import 'package:ocr_visitor/services/base_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String? token;
  final API api = API();
  getAllHistories() async {
    emit(HistoryInitial());
    final SharedPreferences preferences = await prefs;
    token = preferences.getString('token');
    try {
      final response = await api.dio.get(
        'visitors',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        List<HistoryModel> histories = [];
        response.data['data'].forEach((history) {
          histories.add(HistoryModel.fromJson(history));
        });
        emit(HistoryLoaded(histories));
      }
    } catch (e) {
      print(e);
      emit(HistoryError(e.toString()));
    }
  }
}
