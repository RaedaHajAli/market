import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:market/cubits/shop_cubit/shop_cubit.dart';

import '../../models/favorite_model.dart';
import '../../models/home_model.dart';
import '../../screens/product_details.dart';
import '../constant.dart';
import 'componants.dart';

buildProductItem(BuildContext context, ProductModel productModel) {
  ShopCubit cubit = ShopCubit.get(context);
  return GestureDetector(
    onTap: (){
       navigateTo(context, ProductDetails(product: productModel,));
    },
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              CachedNetworkImage(
                  imageUrl: productModel.image,
                  height: 200,
                  width: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error)),
              if (productModel.discount > 0)
                Container(
                  color: Colors.red,
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              productModel.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${productModel.price.round()}\$',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              if (productModel.discount > 0)
                Text(
                  '${productModel.oldPrice.round()}\$',
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: kSecondaryColor,
                      fontSize: 12),
                ),
              IconButton(
                  onPressed: () {
                    cubit.changeItemCart(productModel.id);
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: cubit.inCart[productModel.id]!
                        ? Colors.green
                        : Colors.grey,
                  )),
              IconButton(
                  onPressed: () {
                    cubit.changeFavorite(productModel.id);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: cubit.favorites[productModel.id]!
                        ? Colors.red
                        : Colors.grey,
                  )),
            ],
          )
        ],
      ),
    ),
  );
}
