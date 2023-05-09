import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:market/models/home_model.dart';

buildCarouselSlider({required List<BannerModel> list}) {
  return CarouselSlider(
      items: list.map((e) {
        return  CachedNetworkImage(imageUrl:e.image ,
        
             
           placeholder: (context, url) =>const Center(child:  CircularProgressIndicator()),
        errorWidget: (context, url, error) =>const Icon(Icons.error)
          )
              
       
           
            ;
      }).toList(),
     
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
      ));
}
