import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit/home_cubit.dart';
import '../layout/shopLayout.dart';
import '../modules/login_screen.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';
import '../shared/styles/themes.dart';
import 'cubit/bloc_observer.dart';
import 'modules/on_boarding_screen.dart';
import 'shared/constants.dart';
//



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();

  bool onBoard = CacheHelper.getData(key: 'onBoarding') ?? false;
//test commit
  token = CacheHelper.getData(key: 'token') ?? '';
  bool isLogged = token.isEmpty ? false : true;

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        onBoard: onBoard,
        isLogged: isLogged,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}
class MyApp extends StatelessWidget {
  final bool onBoard;
  final bool isLogged;

  MyApp({
    required this.onBoard,
    required this.isLogged,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..getData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        darkTheme: darkTheme,
        home: onBoard
            ? (isLogged ? const ShopLayout() : LoginScreen())
            : const OnBoardingScreen(),
      ),
    );
  }
}
