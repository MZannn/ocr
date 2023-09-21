part of 'env.dart';

class Routes {
  const Routes({
    required this.path,
    required this.page,
  });
  final String path;
  final Widget page;

  static Routes login = Routes(
    path: 'login',
    page: BlocProvider(
      create: (context) => AuthCubit()..checkToken(),
      child: const LoginView(),
    ),
  );

  static Routes homepage = Routes(
    path: '/homepage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationCubit()..changeScreen(0),
        ),
        BlocProvider(
          create: (context) => FormCubit()..getResidentData(),
        ),
        BlocProvider(
          create: (context) => HistoryCubit()..getVisitorActive(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit()..fetchUser(),
        ),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: const NavigationView(),
    ),
  );
}
