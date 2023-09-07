part of 'camera_cubit.dart';

sealed class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

final class CameraInitial extends CameraState {}

final class TextRecognized extends CameraState {
  final String identityNumber;
  final String name;
  final File? image;

  const TextRecognized(this.identityNumber, this.name, this.image);

  @override
  List<Object> get props => [identityNumber, name];
}

final class CameraInitialized extends CameraState {
  final CameraController controller;

  const CameraInitialized(this.controller);

  @override
  List<Object> get props => [controller];
}
