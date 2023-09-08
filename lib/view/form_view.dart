import 'package:flutter/material.dart';
import '../cubit/camera/camera_cubit.dart';

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
    List<String> personNameList = [
      'John Doe',
      'Alice Smith',
      'Bob Johnson',
      'Emily Brown',
      'Michael Wilson',
      'Sophia Davis',
      'David Lee',
      'Olivia Martinez',
      'James Anderson',
      'Ella Wilson',
      'William Taylor',
      'Emma Jones',
      'Daniel Harris',
      'Grace Miller',
      'Matthew Clark',
      'Ava Taylor',
      'Joseph Garcia',
      'Chloe Lopez',
      'Andrew Hall',
      'Sofia Hernandez',
    ];

    return Scaffold(
      body: Stack(
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
            child: BlocBuilder<CameraCubit, CameraState>(
              builder: (_, state) {
                if (state is TextRecognized) {
                  identityNumberController.text = state.identityNumber;
                  nameController.text = state.name;
                  addressController.text = state.address;
                }
                return SingleChildScrollView(
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
                          context.read<CameraCubit>().scanImage();
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: state is TextRecognized ? 200 : 150,
                          width: state is TextRecognized ? 300 : 250,
                          child: state is TextRecognized
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
                          context.read<CameraCubit>().sendToWhatsapp(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
