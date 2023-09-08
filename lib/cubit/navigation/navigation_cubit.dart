import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());
  void changeScreen(int selectedIndex) {
    emit(NavigationChangeScreen(selectedIndex));
  }
}
