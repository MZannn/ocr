import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:ocr_visitor/env/class/env.dart';
import 'package:ocr_visitor/src/history/model/history_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String? token;
  List<HistoryModel> histories = [];
  getVisitorActive() async {
    List<HistoryModel> historiesByDate = [];
    try {
      emit(HistoryLoading());
      final response = await OCRApi().get(
        path: 'visitors',
      );
      final responseHistoryToday = await OCRApi().get(path: 'visitors', param: {
        'start_date': DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 0, 0, 0)
            .toString(),
        'end_date': DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 23, 59, 59)
            .toString(),
      });
      if (response.statusCode == 200) {
        histories = [];
        response.data['data'].forEach((history) {
          histories.add(HistoryModel.fromJson(history));
        });
      }
      if (responseHistoryToday.statusCode == 200) {
        emit(HistoryLoading());
        responseHistoryToday.data['data'].forEach((history) {
          historiesByDate.add(HistoryModel.fromJson(history));
        });
      }
      emit(
        HistoryLoaded(
          histories: histories,
          historiesByDate: historiesByDate,
        ),
      );
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  getVisitorHistory(String startDate, String endDate) async {
    List<HistoryModel> listHistoriesByDate = [];
    DateTime.parse(endDate);
    DateTime sDate = DateTime(
        DateTime.parse(startDate).year,
        DateTime.parse(startDate).month,
        DateTime.parse(startDate).day,
        0,
        0,
        0);
    DateTime eDate = DateTime(DateTime.parse(endDate).year,
        DateTime.parse(endDate).month, DateTime.parse(endDate).day, 23, 59, 59);

    DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate));
    try {
      final response = await OCRApi().get(path: 'visitors', param: {
        'start_date': sDate.toString(),
        'end_date': eDate.toString(),
      });
      emit(HistoryInitial());
      if (response.statusCode == 200) {
        response.data['data'].forEach((history) {
          listHistoriesByDate.add(HistoryModel.fromJson(history));
        });
        emit(HistoryLoaded(
            histories: histories, historiesByDate: listHistoriesByDate));
      }
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  checkout(int id) async {
    try {
      final response = await OCRApi().put(path: 'visitors/$id');
      if (response.statusCode == 200) {
        getVisitorActive();
      }
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
