import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/cubits/register_cubit/register_cubit.dart';
import 'package:market/screens/login_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../cubits/register_cubit/register_state.dart';
import '../helper/cache_helper.dart';
import '../helper/componants/componants.dart';
import '../helper/constant.dart';
import '../helper/custom_button.dart';
import '../helper/custom_text_field.dart';
import 'home_screen_layout.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(),
        child:const Scaffold(
        
          body: RegisterBody(),
        ));
  }
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({
    super.key,
  });

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  bool inAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          inAsyncCall = true;
        } else {
          inAsyncCall = false;
        }
        if (state is RegisterSuccessState) {
          if (state.registerModel.status) {
            CacheHelper.setData(
                    key: kToken, value: state.registerModel.data!.token)
                .then((value) {
              token = state.registerModel.data!.token;
              navigateToAndFinish(context,const HomeScreen());
            });
          } else {
            buildToast(
                message: state.registerModel.message ?? 'Error',
                state: ToastState.ERORR);
            print(state.registerModel.message);
          }
        }
      },
      builder: (context, state) {
        RegisterCubit cubit = RegisterCubit.get(context);
        return ModalProgressHUD(
          inAsyncCall: inAsyncCall,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Text(
                      'Register',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      label: 'User Name',
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
                      height: 10,
                    ),
                    CustomTextField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        label: 'Password',
                        prefix: Icons.lock_outline,
                        suffixIcon: cubit.isVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        obscureText: cubit.isVisible,
                        suffixPressed: () => cubit.changeVisibilty(),
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.registerUser(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text);
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: 'Register',
                      color: kPrimaryColor,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          cubit.registerUser(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text);
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          child: const Text(
                            'Login now',
                            style:
                                TextStyle(fontSize: 16, color: kSecondaryColor),
                          ),
                          onPressed: () {
                            navigateToAndFinish(context,const LoginScreen());
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
