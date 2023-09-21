part of 'history_cubit.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

final class HistoryLoaded extends HistoryState {
  final List<HistoryModel> histories;
  final List<HistoryModel>? historiesByDate;
  const HistoryLoaded({required this.histories, this.historiesByDate});
  @override
  List<Object> get props => [histories, historiesByDate!];
}

final class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);
  @override
  List<Object> get props => [message];
}

final class HistoryLoading extends HistoryState {}
