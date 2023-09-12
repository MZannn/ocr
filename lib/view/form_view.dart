import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ocr_visitor/models/resident_model.dart';
import '../cubit/form/form_cubit.dart';

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController identityNumberController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController addressPersonController = TextEditingController();
    TextEditingController phoneNumberPersonController = TextEditingController();
    String personName = '';
    File? image;
    List<ResidentModel> residents = [];
    List<String> personNameList = [];

    return Scaffold(
      body: BlocConsumer<FormCubit, FormVisitorState>(
        listener: (context, state) {
          if (state is ResidentsDataSucceedLoaded) {
            residents = state.residents;
            personNameList = residents.map((e) => e.name!).toList();
            if (state.identityNumber != null) {
              identityNumberController.text = state.identityNumber!;
            }
            if (state.name != null) {
              nameController.text = state.name!;
            }
            if (state.address != null) {
              addressController.text = state.address!;
            }
            if (state.image != null) {
              image = state.image!;
            }
          }
        },
        builder: (context, state) {
          if (state is ResidentsDataSucceedLoaded) {
            return Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/half_circle.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Form Pengunjung",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () {
                            context.read<FormCubit>().scanImage();
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            height: 200,
                            width: 300,
                            child: state.image != null
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: FileImage(image!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Text("Pick Image"),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: identityNumberController,
                          decoration: InputDecoration(
                            labelText: 'NIK',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Nama',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: addressController,
                          decoration: InputDecoration(
                            labelText: 'Alamat',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            labelText: 'Nomor Telepon',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            menuMaxHeight: 300,
                            hint: const Text('Pilih Orang yang Ingin Dituju'),
                            items: personNameList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              personName = value!;
                              addressPersonController.text = residents
                                  .firstWhere(
                                      (element) => element.name == personName)
                                  .address!;
                              phoneNumberPersonController.text = residents
                                  .firstWhere(
                                      (element) => element.name == personName)
                                  .phoneNumber!;
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            isDense: true,
                            isExpanded: true,
                            elevation: 0,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: addressPersonController,
                          decoration: InputDecoration(
                            labelText: 'Alamat Orang yang Dituju',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: phoneNumberPersonController,
                          decoration: InputDecoration(
                            labelText: 'Nomor Telepon Orang yang Dituju',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<FormCubit>().sendVisitorData(
                                  identityNumberController.text,
                                  nameController.text,
                                  addressController.text,
                                  phoneNumberController.text,
                                  personName,
                                  addressPersonController.text,
                                  phoneNumberPersonController.text,
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
