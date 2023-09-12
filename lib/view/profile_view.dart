import 'package:flutter/material.dart';
import 'package:ocr_visitor/cubit/auth/auth_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Profile",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is LogoutSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false);
                        }
                      },
                      child: InkWell(
                        onTap: () {
                          context.read<AuthCubit>().logout();
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Logout"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
