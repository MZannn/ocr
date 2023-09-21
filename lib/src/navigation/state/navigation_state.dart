part of 'navigation_cubit.dart';

sealed class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

final class NavigationInitial extends NavigationState {}

final class NavigationChangeScreen extends NavigationState {
  final int selectedIndex;

  const NavigationChangeScreen(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}
