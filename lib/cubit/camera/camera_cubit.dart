import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInitial());
  CameraController? cameraController;
  RecognizedText recognizedText = RecognizedText(text: '', blocks: []);
  TextRecognizer textRecognizer = TextRecognizer();
  String nik = '';
  String name = '';
  String address = '';

  Future<void> scanImage() async {
    try {
      emit(CameraInitial());
      final pictureFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pictureFile != null) {
        CroppedFile? croppedImage = await ImageCropper().cropImage(
          sourcePath: pictureFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 2),
        );
        if (croppedImage != null) {
          emit(
            TextRecognized(
              '',
              '',
              '',
              File(croppedImage.path),
            ),
          );
          emit(CameraInitial());
          final croppedFile = File(croppedImage.path);
          final croppedInputImage = InputImage.fromFile(croppedFile);
          recognizedText = await textRecognizer.processImage(croppedInputImage);
          extractDataFromText(recognizedText);
          log('Nama: $name');
          log('Alamat : $address');
        } else {
          final file = File(pictureFile.path);
          final inputImage = InputImage.fromFile(file);
          recognizedText = await textRecognizer.processImage(inputImage);
          extractDataFromText(recognizedText);
          log('Nama: $name');
        }
        emit(TextRecognized(
          nik,
          name,
          address,
          File(croppedImage!.path),
        ));
      } else {
        emit(CameraInitial());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void extractDataFromText(RecognizedText recognizedText) {
    bool foundNIK = false;
    bool foundName = false;
    try {
      outerloop:
      for (int i = 0; i < recognizedText.blocks.length; i++) {
        for (int j = 0; j < recognizedText.blocks[i].lines.length; j++) {
          var data = recognizedText.blocks[i].lines[j].text;
          log(data);
          if (foundNIK && foundName && isAddress(data)) {
            log('Address: $data');
            address = data.replaceAll(':', '').replaceAll('Alamat', '');
            break outerloop;
          } else if (foundNIK && !foundName) {
            name = data.replaceAll(':', '').replaceAll('Nama', '');
            foundName = true;
          } else if (!foundNIK &&
              isNIK(recognizedText.blocks[i].lines[j].text)) {
            nik = data
                .replaceAll('NIK', '')
                .replaceAll(' ', '')
                .replaceAll(':', '')
                .replaceAll('?', '7')
                .replaceAll('l', '1')
                .replaceAll('L', '1')
                .replaceAll('I', '1')
                .replaceAll('O', '0')
                .replaceAll('B', '8')
                .replaceAll('b', '6')
                .replaceAll('D', '0')
                .replaceAll('S', '5');
            foundNIK = true;
          }
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  bool isNIK(String text) {
    const nikPattern = r'\d{10,16}';
    final nikRegex = RegExp(nikPattern);
    return nikRegex.hasMatch(text);
  }

  bool isAddress(String text) {
    const addressPattern = r'^JL';
    final addressRegex = RegExp(addressPattern);
    return addressRegex.hasMatch(text);
  }
}
