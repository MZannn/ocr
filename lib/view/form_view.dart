import 'package:flutter/material.dart';
import '../cubit/camera/camera_cubit.dart';

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController identityNumberController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController namePersonController = TextEditingController();
    TextEditingController addressPersonController = TextEditingController();
    TextEditingController phoneNumberPersonController = TextEditingController();
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
      appBar: AppBar(
        title: const Text("Data"),
      ),
      body: BlocBuilder<CameraCubit, CameraState>(
        builder: (_, state) {
          if (state is TextRecognized) {
            identityNumberController.text = state.identityNumber;
            nameController.text = state.name;
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    context.read<CameraCubit>().scanImage();
                  },
                  child: SizedBox(
                    height: 200,
                    width: 300,
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
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text("Pick Image"),
                            ),
                          ),
                  ),
                ),
                TextFormField(
                  controller: identityNumberController,
                  decoration: const InputDecoration(
                    labelText: 'NIK',
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                  ),
                ),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Nomor Telepon',
                  ),
                ),
                DropdownButtonFormField(
                  items: personNameList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    namePersonController.text = value.toString();
                  },
                ),
                TextFormField(
                  controller: addressPersonController,
                  decoration: const InputDecoration(
                    labelText: 'Alamat Orang yang Dituju',
                  ),
                ),
                TextFormField(
                  controller: phoneNumberPersonController,
                  decoration: const InputDecoration(
                    labelText: 'Nomor Telepon Orang yang Dituju',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {},
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
              ],
            ),
          );
        },
      ),
    );
  }
}
