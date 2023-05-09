import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/cubits/shop_cubit/shop_cubit.dart';
import 'package:market/cubits/shop_cubit/shop_state.dart';

import 'package:market/helper/componants/build_search_item.dart';
import 'package:market/helper/custom_text_field.dart';
import 'package:market/models/search_model.dart';

import '../helper/componants/componants.dart';
import 'home_screen_layout.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textController = TextEditingController();
  SearchModel? searchModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSearchSuccessState) {
          searchModel = state.searchModel;
        }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search Screen',
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: textController,
                    keyboardType: TextInputType.text,
                    label: 'Search',
                    prefix: Icons.search,
                    onFieldSubmitted: (text) {
                      cubit.searchProduct(text: text);
                   
                    }),
                const SizedBox(
                  height: 5,
                ),

                if (state is ShopSearchLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
               
                if (searchModel!=null && cubit.inCart.isNotEmpty)
                  ListView.separated(
                    itemBuilder: (context, index) {
                      return buildSearchItem(
                          context, searchModel!.data!.data[index]);
                    },
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                    ),
                    itemCount: searchModel!.data!.data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  )
              ]),
            ),
          ),
        );
      },
    );
  }
}
