import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit/home_cubit.dart';
import '../cubit/home_cubit/home_states.dart';
import '../modules/search_screen.dart';
import '../shared/methods.dart';



class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Salla'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(
                    widget: const SearchScreen(),
                    context: context,
                  );
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomIndex(index);
            },
          ),
          body: cubit.bottomBarScreens[cubit.currentIndex],
        );
      },
    );
  }
}
