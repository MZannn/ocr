import 'package:flutter/material.dart';
import 'package:ocr_visitor/src/form_visitor/widget/form_view.dart';
import 'package:ocr_visitor/src/history/widget/history_view.dart';
import 'package:ocr_visitor/src/navigation/state/navigation_cubit.dart';
import 'package:ocr_visitor/src/profile/widget/profile_view.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          if (state is NavigationChangeScreen) {
            switch (state.selectedIndex) {
              case 0:
                return const FormView();
              case 1:
                return const HistoryView();
              case 2:
                return const ProfileView();
              default:
                return const SizedBox();
            }
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          if (state is NavigationChangeScreen) {
            var navCubit = context.read<NavigationCubit>();
            return BottomAppBar(
              color: Colors.white,
              padding: EdgeInsets.zero,
              child: Container(
                height: 70,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        navCubit.changeScreen(0);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            state.selectedIndex == 0
                                ? Icons.edit_note_rounded
                                : Icons.edit_note_rounded,
                            color: state.selectedIndex == 0
                                ? Colors.blue
                                : Colors.grey[300],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Form",
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navCubit.changeScreen(1);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            state.selectedIndex == 1
                                ? Icons.location_history_rounded
                                : Icons.location_history_outlined,
                            color: state.selectedIndex == 1
                                ? Colors.blue
                                : Colors.grey[300],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Riwayat",
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navCubit.changeScreen(2);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            state.selectedIndex == 2
                                ? Icons.person
                                : Icons.person_outline_rounded,
                            color: state.selectedIndex == 2
                                ? Colors.blue
                                : Colors.grey[300],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Akun",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
