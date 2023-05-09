import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:market/helper/componants/componants.dart';
import 'package:market/screens/home_screen_layout.dart';

import '../models/home_model.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key, required this.product}) : super(key: key);

final  ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: IconButton(
            onPressed: () {
              navigateToAndFinish(context,const HomeScreen());
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          CachedNetworkImage(
            imageUrl:
                product.image,
            height: 400,
            width: 400,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              Text(
                '${product.price.round()}\$',
                style:const TextStyle(fontSize: 18),
              ),
              Text(
                '${product.oldPrice.round()}\$',
                style:const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.red,
                    fontSize: 18),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
           Text(
            product.name,
            style:const TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          const SizedBox(
            height: 20,
          ),
           Text(
           product.description,
            style:const TextStyle(fontSize: 23, fontWeight: FontWeight.w300),
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
        ]),
      ),
    );
  }
}
