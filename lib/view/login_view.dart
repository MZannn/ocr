import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const Text("Login"),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide(
                        color: Colors.blue[900]!,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide(
                        color: Colors.blue[900]!,
                      ),
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    labelText: "Username",
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/form');
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
