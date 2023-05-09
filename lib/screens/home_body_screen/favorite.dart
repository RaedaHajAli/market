import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/cubits/shop_cubit/shop_state.dart';
import 'package:market/helper/componants/build_favorite_item.dart';


import '../../cubits/shop_cubit/shop_cubit.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            ConditionalBuilder(
              condition: (state is ! ShopGetFavoriteLoadingState)&&(cubit.favoriteModel!= null)&&(cubit.inCart.isNotEmpty),
              builder: (context) => ListView.separated(
                shrinkWrap: true,
                physics:const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildFavoriteItem(
                    context, cubit.favoriteModel!.data!.data[index].product),
                itemCount: cubit.favoriteModel!.data!.data.length,
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
      },
    );
    
  }
}
