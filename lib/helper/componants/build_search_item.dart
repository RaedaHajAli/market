import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../cubits/shop_cubit/shop_cubit.dart';
import '../../models/favorite_model.dart';
import '../constant.dart';

buildSearchItem(BuildContext context, Product product) {
  ShopCubit cubit = ShopCubit.get(context);
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     

      CachedNetworkImage(
          imageUrl: product.image,
          height: 150,
          width: 150,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error)),
    
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
                 
                     IconButton(
                      onPressed: () {
                        cubit.changeItemCart(product.id);
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: cubit.inCart[product.id]==null ||cubit.inCart[product.id]==false?
                        Colors.grey
                        :Colors.green
                            ,
                      )),
                  IconButton(
                      onPressed: () {
                        cubit.changeFavorite(product.id);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color:
                        cubit.favorites[product.id]==null ||cubit.favorites[product.id]==false?
                         Colors.grey:Colors.red
                            ,
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
