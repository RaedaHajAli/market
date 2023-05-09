import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../cubits/shop_cubit/shop_cubit.dart';
import '../../models/favorite_model.dart';
import '../constant.dart';

buildFavoriteItem(BuildContext context, Product product) {
  ShopCubit cubit = ShopCubit.get(context);
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: Alignment.bottomLeft,
        children: [
          CachedNetworkImage(
              imageUrl: product.image,
              height: 150,
              width: 150,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error)),
          if (product.discount > 0)
            Container(
              color: Colors.red,
              child: const Text(
                'DISCOUNT',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
        ],
      ),
      // const SizedBox(
      //   width: 3,
      // ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${product.price.round()}\$',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  if (product.discount > 0)
                    Text(
                      '${product.oldPrice.round()}\$',
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: kSecondaryColor,
                          fontSize: 12),
                    ),
                     IconButton(
                      onPressed: () {
                         cubit.changeItemCart(product.id);
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: cubit.inCart[product.id]!
                            ? Colors.green
                            : Colors.grey,
                      )),
                  IconButton(
                      onPressed: () {
                        cubit.changeFavorite(product.id);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: cubit.favorites[product.id]!
                            ? Colors.red
                            : Colors.grey,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    ],
  );
}
