

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/cubits/shop_cubit/shop_cubit.dart';

import 'package:market/helper/componants/build_carousel_slider.dart';
import 'package:market/helper/componants/build_gridview.dart';
import 'package:market/models/categories_model.dart';
import 'package:market/models/home_model.dart';

import '../../cubits/shop_cubit/shop_state.dart';
import '../../helper/componants/build_category_item.dart';
import '../../helper/componants/build_product_item.dart';


class Products extends StatelessWidget {
  const Products({super.key});
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (index, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoriesModel!=null && cubit.homeModel!=null,
          builder: (context) =>buildProductsScreen(context,cubit.categoriesModel!,cubit.homeModel!) ,
          fallback: (context) =>const Center(child:  CircularProgressIndicator()),
          );
       
      },
    );
  }
}
buildProductsScreen(BuildContext context,CategoriesModel categoriesModel, HomeModel homeModel){
   return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
     
             buildCarouselSlider(list: homeModel.data!.banners),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Container(
                  height: 150,
                  child: ListView.separated(
                    itemBuilder: (context, index) => buildCategoryItem(context,categoriesModel.data!.dataList[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 5,
                    ),
                    itemCount: categoriesModel.data!.dataList.length,
                    scrollDirection: Axis.horizontal,
                    physics:const BouncingScrollPhysics(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'All Products',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                buildGridView(
                context,
                homeModel.data!.products,
                (index) => buildProductItem(context,homeModel.data!.products[index])),
              ],
            ),
          ),
        );
}
