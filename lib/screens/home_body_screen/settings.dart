import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:market/helper/componants/componants.dart';
import 'package:market/helper/constant.dart';
import 'package:market/helper/custom_button.dart';
import 'package:market/helper/custom_text_field.dart';



import '../../cubits/shop_cubit/shop_cubit.dart';
import '../../cubits/shop_cubit/shop_state.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, index) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        //   LoginModel? userData = cubit.userData;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConditionalBuilder(
                condition: (state is! ShopUpdateProfileLoadingState) &&
                    (cubit.userData != null),
                builder: (context) {
                  nameController.text = cubit.userData!.data!.name;
                  emailController.text = cubit.userData!.data!.email;
                  phoneController.text = cubit.userData!.data!.phone;
                  return Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5,top: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            label: 'Name',
                            prefix: Icons.person,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: Icons.email,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: phoneController,
                            keyboardType: TextInputType.name,
                            label: 'Phone Number',
                            prefix: Icons.phone,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            text: 'LOGOUT',
                            color: kPrimaryColor,
                            onTap: () {
                              signOut(context);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            text: 'UPDATE',
                            color: kPrimaryColor,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.updateProfile(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator())),
          ],
        );
      },
    );
  }
}
