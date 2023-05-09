import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:market/models/categories_model.dart';

buildCategoryItem(BuildContext context, CategoriesData categoriesData) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CachedNetworkImage(
        imageUrl:categoriesData.image ,
        width: 120,
      height: 120,
         placeholder: (context, url) =>const Center(child:  CircularProgressIndicator()),
        errorWidget: (context, url, error) =>const Icon(Icons.error)
        ),
      
      Container(
        padding:const EdgeInsets.only(left: 2),
        width: 120,
        alignment: Alignment.centerLeft,
        color: Colors.black.withOpacity(0.45),
        child: Text(
          categoriesData.name.toUpperCase(),
          overflow: TextOverflow.ellipsis,
          style:const TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
    ],
  );
}
