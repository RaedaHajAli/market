import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/cubits/shop_cubit/shop_cubit.dart';

import '../../cubits/shop_cubit/shop_state.dart';
import '../../helper/componants/build_category_screen_item.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (index, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                    
                    ConditionalBuilder(
                        condition: cubit.categoriesModel != null,
                        builder: (context) {
                          return ListView.separated(
                            itemBuilder: (context, index) =>
                                buildCategoryScreenItem(
                                    context,
                                    cubit.categoriesModel!.data!
                                        .dataList[index]),
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.grey[100],
                              thickness: 1,
                            ),
                            itemCount:
                                cubit.categoriesModel!.data!.dataList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          );
                        },
                        fallback: (context)=>const Center(child: CircularProgressIndicator()))
                  ],
                ),
              ));
        });
  }
}
