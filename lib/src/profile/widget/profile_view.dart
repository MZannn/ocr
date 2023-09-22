import 'package:flutter/material.dart';
import 'package:ocr_visitor/env/class/env.dart';
import 'package:ocr_visitor/env/extension/on_context.dart';
import 'package:ocr_visitor/src/login/state/auth_cubit.dart';
import 'package:ocr_visitor/src/profile/state/profile_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    String getInitials(String userName) => userName.isNotEmpty
        ? userName.trim().split(' ').map((l) => l[0]).take(2).join()
        : '';
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 300,
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
                height: 36,
              ),
              Container(
                height: 105,
                width: 105,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    height: 90,
                    width: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            if (state is ProfileLoaded) {
                              return Text(
                                getInitials(state.user.name!.toUpperCase()),
                                style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.lightBlue,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      // user?.data?.user?.profilePhotoPath == null
                      //     ?
                      //     : Image.network(
                      //         "",
                      //         fit: BoxFit.cover,
                      //       ),
                    ),
                  ),
                ),
              ),
              // Text(
              //   '${user?.data?.user?.position}',
              //   style: textTheme.bodyMedium!.copyWith(color: Colors.white),
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              // ),
              const SizedBox(
                height: 6,
              ),
              Flexible(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoaded) {
                      return Text(
                        state.user.name!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return state is ProfileLoaded
                      ? Text(
                          '${state.user.email}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : const SizedBox();
                },
              ),
              const SizedBox(
                height: 50,
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
                          context.toRemoveNamed(
                            route: Routes.login.path,
                          );
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
