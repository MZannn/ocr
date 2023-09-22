import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ocr_visitor/env/extension/on_context.dart';
import 'package:ocr_visitor/src/form_visitor/state/form_cubit.dart';

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController identityNumberController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController phoneNumberPersonController = TextEditingController();
    TextEditingController addressPersonController = TextEditingController();
    String personName = '';

    return Scaffold(
      body: BlocConsumer<FormCubit, FormVisitorState>(
        listener: (context, state) {
          if (state is ResidentsDataSucceedLoaded) {
            if (state.identityNumber != null) {
              identityNumberController.text = state.identityNumber!;
            }
            if (state.name != null) {
              nameController.text = state.name!;
            }
            if (state.address != null) {
              addressController.text = state.address!;
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
                  decoration: const BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
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
                                        image: FileImage(state.image!),
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
                        DropdownSearch(
                          items: state.residents.map((e) {
                            return "Nama : ${e.name}\nNo Hp: ${e.phoneNumber}";
                          }).toList(),
                          popupProps: const PopupProps.menu(
                            showSearchBox: true,
                          ),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            baseStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 8,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                          ),
                          selectedItem: personName,
                          dropdownBuilder: (context, selectedItem) {
                            return selectedItem != ''
                                ? Text(
                                    selectedItem
                                        .toString()
                                        .split('\n')[0]
                                        .replaceAll('Nama : ', ''),
                                  )
                                : const Text("Pilih Orang yang Ingin Dituju");
                          },
                          onChanged: (value) {
                            personName = value!
                                .split('\n')[0]
                                .toString()
                                .replaceAll('Nama : ', '');
                            addressPersonController.text = state.residents
                                .firstWhere(
                                    (element) => element.name == personName)
                                .address!;
                            phoneNumberPersonController.text = state.residents
                                .firstWhere(
                                    (element) => element.name == personName)
                                .phoneNumber!;
                          },
                        ),
                        // DropdownButtonHideUnderline(
                        //   child: DropdownButtonFormField(
                        //     selectedItemBuilder: (context) {
                        //       return state.residents.map((e) {
                        //         return Text(e.name!);
                        //       }).toList();
                        //     },
                        //     menuMaxHeight: 300,
                        //     hint: const Text('Pilih Orang yang Ingin Dituju'),
                        //     items: state.residents
                        //         .map(
                        //           (e) => DropdownMenuItem(
                        //             value: e.name!,
                        //             child: Container(
                        //               decoration: BoxDecoration(
                        //                 border: Border.all(
                        //                   color: Colors.grey[300]!,
                        //                 ),
                        //                 borderRadius: BorderRadius.circular(8),
                        //               ),
                        //               padding: const EdgeInsets.symmetric(
                        //                 horizontal: 16,
                        //               ),
                        //               margin: const EdgeInsets.only(
                        //                 bottom: 8,
                        //               ),
                        //               width: double.infinity,
                        //               child: Column(
                        //                 children: [
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         "Nama : ",
                        //                       ),
                        //                       Text(
                        //                         e.name!,
                        //                         overflow: TextOverflow.ellipsis,
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Row(
                        //                     children: [
                        //                       const Text(
                        //                         "No Hp : ",
                        //                       ),
                        //                       Text(
                        //                         e.phoneNumber!,
                        //                         overflow: TextOverflow.ellipsis,
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //         )
                        //         .toList(),
                        //     onChanged: (value) {
                        //       personName = value!;
                        //       addressPersonController.text = state.residents
                        //           .firstWhere(
                        //               (element) => element.name == personName)
                        //           .address!;
                        //       phoneNumberPersonController.text = state.residents
                        //           .firstWhere(
                        //               (element) => element.name == personName)
                        //           .phoneNumber!;
                        //     },
                        //     decoration: const InputDecoration(
                        //       filled: true,
                        //       fillColor: Colors.white,
                        //       border: OutlineInputBorder(),
                        //       contentPadding: EdgeInsets.symmetric(
                        //         horizontal: 8,
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.all(
                        //           Radius.circular(8),
                        //         ),
                        //         borderSide: BorderSide(
                        //           color: Colors.blue,
                        //         ),
                        //       ),
                        //     ),
                        //     isDense: true,
                        //     isExpanded: true,
                        //     elevation: 0,
                        //   ),
                        // ),
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
                        // DropdownSearch(
                        //   items: state.residents
                        //       .map((e) => e.phoneNumber)
                        //       .toList(),
                        //   selectedItem: phoneNumber,
                        //   popupProps: const PopupProps.menu(
                        //     showSearchBox: true,
                        //   ),
                        //   onChanged: (value) {
                        //     phoneNumber = value!;
                        //     personName = state.residents
                        //         .firstWhere(
                        //             (element) => element.phoneNumber == value)
                        //         .name!;
                        //   },
                        // ),
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
                            if (state.image != null) {
                              context.read<FormCubit>().sendVisitorData(
                                    personName: personName,
                                    nik: identityNumberController.text,
                                    name: nameController.text,
                                    address: addressController.text,
                                    phoneNumber: phoneNumberController.text,
                                    image: state.image!,
                                    residentsId: state.residents
                                        .firstWhere((element) =>
                                            element.name == personName)
                                        .id!,
                                  );
                            } else {
                              context.alert(label: 'Foto belum dipilih');
                            }
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
