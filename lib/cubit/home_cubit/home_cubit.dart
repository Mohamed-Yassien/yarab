import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarab/cubit/home_cubit/home_states.dart';

import '../../models/home_model.dart';
import '../../modules/categories_Screen.dart';
import '../../modules/favorites_screen.dart';
import '../../modules/home_screen.dart';
import '../../modules/settings_screen.dart';
import '../../network/endpoints.dart';
import '../../network/remote/dio_helper.dart';
import '../../shared/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> bottomBarScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.grid_view,
        ),
        label: 'Categories'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
        ),
        label: 'Favorites'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
        label: 'Settings'),
  ];

  int currentIndex = 0;

  void changeBottomIndex(int index) {
    currentIndex = index;
    emit(HomeBarChangeIndexState());
  }

  HomeModel? homeModel;

  void getData() {
    emit(HomeLoadingState());
    DioHelper.getData(
      url: HOME_END_POINT,
      token: token,
    ).then((value) {
      print(token);
      homeModel = HomeModel.fromJson(value.data);
      print('${homeModel?.status}');
      emit(HomeGetDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(
        HomeGetDataErrorState(error.toString()),
      );
    });
  }
}
