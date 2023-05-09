import 'package:flutter/material.dart';
import 'package:market/models/categories_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
           




buildCategoryScreenItem(BuildContext context,CategoriesData categoriesData) {
  return Container(
    width: double.infinity,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedNetworkImage(imageUrl:categoriesData.image ,
        width: 150,
        height: 150,
          placeholder: (context, url) =>const Center(child:  CircularProgressIndicator()),
        errorWidget: (context, url, error) =>const Icon(Icons.error)
          ),
        const SizedBox(width: 20,),
        Expanded(
          child: Text(
            categoriesData.name.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: 20,), 
        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
      ],
    ),
  );
}