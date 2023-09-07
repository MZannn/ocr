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

  Future<void> scanImage() async {
    try {
      emit(CameraInitial());
      final pictureFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pictureFile != null) {
        CroppedFile? croppedImage =
            await ImageCropper().cropImage(sourcePath: pictureFile.path);
        if (croppedImage != null) {
          final croppedFile = File(croppedImage.path);
          final croppedInputImage = InputImage.fromFile(croppedFile);
          recognizedText = await textRecognizer.processImage(croppedInputImage);
          extractDataFromText(recognizedText);
          log('Nama: $name');
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
          if (foundNIK) {
            name = data.replaceAll(':', '');
            break outerloop;
          } else if (!foundNIK &&
              isNIK(recognizedText.blocks[i].lines[j].text)) {
            nik = data
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
    const nikPattern = r'\d{11,16}';
    final nikRegex = RegExp(nikPattern);
    return nikRegex.hasMatch(text);
  }
}
