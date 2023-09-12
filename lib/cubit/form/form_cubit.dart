import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_visitor/models/resident_model.dart';
import 'package:ocr_visitor/services/base_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
part 'form_state.dart';

class FormCubit extends Cubit<FormVisitorState> {
  FormCubit() : super(FormInitial());
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final API api = API();
  List<ResidentModel> residents = [];
  CameraController? cameraController;
  RecognizedText recognizedText = RecognizedText(text: '', blocks: []);
  TextRecognizer textRecognizer = TextRecognizer();

  String nik = '';
  String name = '';
  String address = '';
  String? token;
  Future<void> scanImage() async {
    try {
      emit(FormInitial());
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
          emit(FormInitial());
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
        emit(ResidentsDataSucceedLoaded(
          residents,
          name,
          nik,
          address,
          File(croppedImage!.path),
        ));
      } else {
        emit(FormInitial());
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
                .replaceAll('J', '1')
                .replaceAll('U', '0')
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

  // Future<void> sendToWhatsapp(
  //     String identityNumber,
  //     String name,
  //     String address,
  //     String phoneNumber,
  //     String personName,
  //     String personAddress,
  //     String personPhoneNumber) async {
  //   final Uri uri = Uri.parse(
  //       "https://wa.me/+6281952951440?text=Halo%20Bapak/Ibu%20$personName%20ada%20tamu%20yang%20ingin%20berkunjung%20ke%20rumah%20Bapak/Ibu%20atas%20nama%20$name%20Apakah%20Bapak/Ibu%20berkenan%20menerima%20tamu%20ini");
  //   if (!await launchUrl(uri)) {
  //     throw Exception('Could not launch ${uri.toString()}');
  //   }
  // }

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

  getResidentData() async {
    emit(FormInitial());
    final SharedPreferences preferences = await prefs;
    token = preferences.getString('token');
    try {
      // with bearer token

      final response = await api.dio.get(
        'residents',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.data['status'] == 'success') {
        response.data['data'].forEach((element) {
          residents.add(ResidentModel.fromJson(element));
        });
        emit(
          ResidentsDataSucceedLoaded(residents, null, null, null, null),
        );
      } else {
        emit(FormInitial());
      }
    } catch (e) {
      emit(
        ResidentsDataFailedLoaded(e.toString()),
      );
    }
  }

  sendVisitorData(String nik, String name, String address, String phoneNumber,
      String personName, String personAddress, String personPhoneNumber) async {
    emit(FormInitial());
    log('nik $nik');
    log('name $name');
    log('alamat $address');
    log('phoneNumber $phoneNumber');
    log('personName $personName');
    log('personAddress $personAddress');
    log('personPhoneNumber $personPhoneNumber');
    log('date ${DateTime.now()}');
    log('token $token');
    Map<String, dynamic> data = {
      'identity_number': nik,
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
      'person_to_visit': personName,
      'person_address': personAddress,
      'person_phone_number': personPhoneNumber,
      'date': DateTime.now().toString()
    };
    try {
      final response = await api.dio.post(
        'send-visitor-data',
        data: data,
        options: Options(
          // followRedirects: false,
          // validateStatus: (status) {
          //   return status! < 500;
          // },
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('data');
      log('response ${response.data}');
      if (response.statusCode == 200) {
        final Uri uri = Uri.parse(
            "https://wa.me/+6281952951440?text=Halo%20Bapak/Ibu%20$personName%20ada%20tamu%20yang%20ingin%20berkunjung%20ke%20rumah%20Bapak/Ibu%20atas%20nama%20$name%20Apakah%20Bapak/Ibu%20berkenan%20menerima%20tamu%20ini");
        if (!await launchUrl(uri)) {
          throw Exception('Could not launch ${uri.toString()}');
        }
      }
      emit(
        ResidentsDataSucceedLoaded(
          residents,
          '',
          '',
          '',
          null,
        ),
      );
    } catch (e) {
      print(e);
      emit(FormVisitorError(
        e.toString(),
      ));
    }
  }
}