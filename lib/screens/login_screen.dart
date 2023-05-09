import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/cubits/login_cubit/login_cubit.dart';
import 'package:market/cubits/login_cubit/login_state.dart';
import 'package:market/helper/constant.dart';
import 'package:market/helper/custom_text_field.dart';
import 'package:market/screens/home_screen_layout.dart';
import 'package:market/screens/register_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/cache_helper.dart';
import '../helper/componants/componants.dart';
import '../helper/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child:const Scaffold(
        // appBar: AppBar(),
        body: LoginBody(),
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({
    super.key,
  });

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool inAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          inAsyncCall = true;
        } else {
          inAsyncCall = false;
        }
        if (state is LoginSuccessState) {
          if (state.loginModel.status) {
            CacheHelper.setData(
                    key: kToken, value: state.loginModel.data!.token)
                .then((value) {
              token = state.loginModel.data!.token;
              navigateToAndFinish(context,const HomeScreen());
            });
          } else {
            buildToast(
                message: state.loginModel.message ?? 'Error',
                state: ToastState.ERORR);
            print(state.loginModel.message);
          }
        }
      },
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return ModalProgressHUD(
          inAsyncCall: inAsyncCall,
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 250,
                      ),
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(
                        height: 20,
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
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffixIcon:cubit.isVisible? Icons.visibility:Icons.visibility_off,
                          obscureText: cubit.isVisible,
                          suffixPressed: () => cubit.changeVisibilty(),
                          onFieldSubmitted: (value){
                            if (formKey.currentState!.validate()) {
                            cubit.loginUser(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: 'Login',
                        color: kPrimaryColor,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cubit.loginUser(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account',
                            style: TextStyle(fontSize: 16),
                          ),
                          TextButton(
                            child: const Text(
                              'Register now',
                              style: TextStyle(
                                  fontSize: 16, color: kSecondaryColor),
                            ),
                            onPressed: () {
                              navigateTo(context,const RegisterScreen());
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
