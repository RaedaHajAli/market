import 'package:flutter/material.dart';
import 'package:market/helper/cache_helper.dart';
import 'package:market/helper/componants/componants.dart';
import 'package:market/on_boarding/on_boarding_model.dart';
import 'package:market/screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../helper/constant.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
               
                navigateToAndFinish(context,const LoginScreen());
                 CacheHelper.setData(key: kOnboarding, value: true);
              },
              child: const Text(
                'Skip',
                style: TextStyle(fontSize: 21, color: kSecondaryColor),
              ),
            )
          ],
        ),
        body: PageView.builder(
          itemBuilder: (context, index) =>
              buildOnBoardingItem(context, onBoardingList[index]),
          itemCount: onBoardingList.length,
          controller: pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            if (index == onBoardingList.length - 1) {
              setState(() {
                isLast = true;
              });
            } else {
              setState(() {
                isLast = false;
              });
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (isLast) {
              navigateTo(context,const LoginScreen());
              CacheHelper.setData(key: kOnboarding, value: true);
            } else {
              pageController.nextPage(
                  duration: const Duration(microseconds: 750),
                  curve: Curves.fastLinearToSlowEaseIn);
            }
          },
          child: const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
        ));
  }

  Widget buildOnBoardingItem(BuildContext context, OnBoardingModel page) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 150,
        ),
        Image.asset(
          page.image,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          page.title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: kPrimaryColor,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        SmoothPageIndicator(
          controller: pageController,
          count: onBoardingList.length,
          effect: const ExpandingDotsEffect(
              dotColor: kPrimaryColor, activeDotColor: kSecondaryColor),
        )
      ],
    );
  }
}
