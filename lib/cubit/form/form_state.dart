part of 'form_cubit.dart';

sealed class FormVisitorState extends Equatable {
  const FormVisitorState();

  @override
  List<Object> get props => [];
}

final class FormInitial extends FormVisitorState {}

final class TextRecognized extends FormVisitorState {
  final String identityNumber;
  final String name;
  final String address;
  final File? image;

  const TextRecognized(
      this.identityNumber, this.name, this.address, this.image);

  @override
  List<Object> get props => [identityNumber, name];
}

final class CameraInitialized extends FormVisitorState {
  final CameraController controller;

  const CameraInitialized(this.controller);

  @override
  List<Object> get props => [controller];
}

final class ResidentsDataSucceedLoaded extends FormVisitorState {
  final List<ResidentModel> residents;
  final String? identityNumber;
  final String? name;
  final String? address;
  final File? image;
  const ResidentsDataSucceedLoaded(
    this.residents,
    this.name,
    this.identityNumber,
    this.address,
    this.image,
  );
  @override
  List<Object> get props =>
      [residents, name!, identityNumber!, address!, image!];
}

final class ResidentsDataFailedLoaded extends FormVisitorState {
  final String message;
  const ResidentsDataFailedLoaded(this.message);
  @override
  List<Object> get props => [message];
}

final class FormVisitorError extends FormVisitorState {
  final String message;
  const FormVisitorError(this.message);
  @override
  List<Object> get props => [message];
}
