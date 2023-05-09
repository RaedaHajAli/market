import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/cubits/shop_cubit/shop_cubit.dart';
import 'package:market/cubits/shop_cubit/shop_state.dart';
import 'package:market/helper/componants/componants.dart';

import 'package:market/screens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            // centerTitle: true,
            title: Text(
          cubit.titles[cubit.currentIndex],
          style: Theme.of(context).textTheme.bodyLarge,

        ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context,const SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                  ))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: true,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: cubit.items),
        );
      },
    );
  }
}
