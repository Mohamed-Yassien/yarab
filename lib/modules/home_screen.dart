import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit/home_cubit.dart';
import '../cubit/home_cubit/home_states.dart';



class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return cubit.homeModel == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  CarouselSlider(
                    items: cubit.homeModel?.data?.banners
                        ?.map(
                          (e) => Image(
                            image: NetworkImage(e.image!),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      initialPage: 0,
                      autoPlayInterval: const Duration(seconds: 3),
                      scrollDirection: Axis.horizontal,
                      reverse: false,
                      enableInfiniteScroll: true,
                      viewportFraction: 1.0,
                    ),
                  ),
                ],
              );
      },
    );
  }
}
